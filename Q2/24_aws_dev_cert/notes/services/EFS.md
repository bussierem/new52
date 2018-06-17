# Elastic File System (EFS)
## What is it?
* A file storage service for EC2 instances
* Simple interface that allows you to create/configure file systems
* Storage capacity is **auto-scaled**

### Features
* Supports the Network File System v4 (NFSv4) protocol
* Only pay for the storage you use (no pre-provisioning needed)
* Can scale up to multiple petabytes
* Can support thousands of concurrent NFS connections
* Data is stored across multiple AZs within a Region
* "Read After Write" Consistency, but _block based_ storage, not _object based_ storage

### Notes from Lab
### NEED TO KNOW (Developer Exam)
* EC2
  * `aws ec2 describe-instances`
  * `aws ec2 describe-images`
  * `aws ec2 run-instances`
    * **NOTE:** `aws ec2 start-instances` ONLY _STARTS_ **STOPPED** INSTANCES!
  * `aws ec2 terminate-instances --instance-ids <instance_id>`
* S3
  * `aws s3 cp --recursive s3://<bucket_name> <destination_path>`
    * Copies data from bucket to current instance
