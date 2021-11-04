# AviatrixAWSHubSpoke

This code launches an Aviatrix Hub and 2 Spoke in both AWS and Azure with 1 VM in each spoke subnet.

It calls the following modules

1. AWS Transit
2. Azure Transit
3. AWS Spoke (incls EC2 instances) x2
4. Azure Spoke x2
5. MC Interconnect
6. Azure VMs x2
