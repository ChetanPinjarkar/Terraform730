import boto3
import json

def lambda_handler(event, context):
    client = boto3.client('ec2')
    response = client.run_instances(
        ImageId = "ami-0ddfba243cbee3768",
        InstanceType = "t2.micro",
        KeyName = "aws2",
        MaxCount = 1,
        MinCount = 1
    )