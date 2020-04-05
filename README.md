# Autoscaling excercise

This scenario automates the build of 3 Linux based web servers. 
The `scripts/stress_test.sh` script generates traffic against the deployed ELB.
Once the traffic reaches a high water threshold (more than 50% of average CPUUsage of the AS group), the number of web servers increases from 3 to 5. When traffic drops below a low water threshold (lower than 30% of average CPUUsage of the AS group) the web farm scales back down from 5 web servers to 3
Also, a monitoring dashboard is deployed showing:

* Active traffic requests
* Historic web server scaling

## Deployment

Configure your AWS account credentials. Deploy the following stacks from the cloudformation folder with a custom name:

```bash
aws cloudformation deploy --template-file 01-network-layer.yml --stack-name web-server-stress-test-network --parameter-overrides Name=web-server-stress-test-network
```

```bash
aws cloudformation deploy --template-file 02-webservers.yml --stack-name web-server-stress-test --parameter-overrides Name=web-server-stress-test
```

## Generate traffic

Run the `scripts/stress_test.sh` script against the ELB endpoint (simple copy the LoadBalancerUrl output from the second stack):

```bash
./scripts/stress_test.sh <LoadBalancerUrl>
```

## Observe the monitoring dashboard and metrics:

Open the CloudWatch dashboard and observe the historic web server scaling and active request counts.

![dashboard](https://github.com/tohimon/01-autoscaling/blob/master/doc/dashboard.png)
