#!/bin/bash

# Check if the bucket exists
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    echo "Bucket $BUCKET_NAME already exists."
else
    # Create the bucket if it doesn't exist
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION" --create-bucket-configuration LocationConstraint="$AWS_REGION"
    echo "Bucket $BUCKET_NAME created successfully."
fi
