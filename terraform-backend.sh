#!/bin/bash

BUCKET_NAME="terraform-state-devops-2024"
REGION="us-east-1"

# Check if the bucket exists
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    echo "Bucket $BUCKET_NAME already exists."
else
    # Create the bucket if it doesn't exist
    aws s3api create-bucket \
    --bucket $BUCKET_NAME \
    --region $REGION

    aws s3api put-bucket-versioning \
    --bucket $BUCKET_NAME \
    --versioning-configuration Status=Enabled

    aws s3api put-object-lock-configuration \
    --bucket $BUCKET_NAME \
    --object-lock-configuration '{"ObjectLockEnabled": "Enabled"}'
    
    echo "Bucket $BUCKET_NAME created successfully."
fi
