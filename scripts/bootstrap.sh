# Confirm Details
echo "PROJECT_ID" $PROJECT_ID
echo "BUCKET_LOCATION" $BUCKET_LOCATION
echo "BUCKET_NAME" $BUCKET_NAME
# echo "ENCRYPTION_KEY_ID" $ENCRYPTION_KEY_ID

echo
read -p "Are you sure?(Y/n) " -n 1 -r
echo 
if [[ $REPLY =~ ^[Y]$ ]]
then
    echo "Setting up GCP..."
    #set project
    echo "Setting GCP Project to ${PROJECT_ID}..." 
    gcloud config set project $PROJECT_ID

    # Create a bucket to hold state
    echo "Creating bucket ${BUCKET_NAME} in ${BUCKET_LOCATION}..."  
    gcloud storage buckets create $BUCKET_NAME --location=$BUCKET_LOCATION --uniform-bucket-level-access

    # # Create and save a state encryption key
    # echo "Generating tf state encryption key (${ENCRYPTION_KEY_ID})..."  
    # gcloud secrets create $ENCRYPTION_KEY_ID \
    #     --replication-policy="automatic"
    # python3 -c 'import os;import base64;print(base64.b64encode(os.urandom(32)).decode("utf-8"))' |  gcloud secrets versions add $ENCRYPTION_KEY_ID --data-file=-
else 
 echo
 echo "Successfully Canceled"
fi
