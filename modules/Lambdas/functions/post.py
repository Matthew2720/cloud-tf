import json
import boto3
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    #Implementation on push an object to a DB

    return {
            'statusCode': 200,
            'body': json.dumps('post method')
        }
