import os
import boto3

# We get these from the environment vars from variables.tf
environment = os.environ['environment']
subnet_id = os.environ['subnet_id']
message = os.environ['to_print']

def lambda_handler(event, context):
    print(message)
    return 0
