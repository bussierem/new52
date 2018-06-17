# 10,000 Foot Overview of Services

### AWS Global Infrastructure
* **Regions:**  A geographical area - Consists of 2+ Availability Zones (AZs)
* **Availability Zones (AZs):**  Just a Data Center (or multiple) for AWS racks
  * Each has redundant power, networking, and connectivity, housed in separate facilities
* **Edge Locations:**  Endpoints for AWS which are used for caching content
  * Usually uses CloudFront, Amazon's CDN

### AWS Services
_+: Important for Developer Associate Course_
* +**Compute**
  * [EC2 (Elastic Compute Cloud)](services/EC2.md) - Virtual Machines inside the AWS Platform
  * EC2 Container Service - Run and manage Docker containers at scale
  * +Elastic Beanstalk - Upload code, and beanstalk takes care of autoscaling, load balancers, etc
  * +Lambda - Code you upload, control when it executes - no worrying about machines etc, just code
  * Lightsail - Virtual Private Service (VPS) - RDP or SSH access and management console for a server
  * Batch - Used for Batch Computing
* +**Storage**
  * S3 (Simple Storage Service) - Object-based storage in "buckets"
  * EFS (Elastic File System) - Network-attached storage - mount EFS volumes to multiple VMs
  * Glacier - Data Archiving
  * Snowball - Bring large amounts of data into the AWS datacenter
  * Storage Gateway - VMs installed in your office that replicate information back to S3
* +**Databases**
  * RDS (Relational Database Service) - SQL, PostreSQL, Oracle, etc.
  * +++DynamoDB - Non-relational databases
  * Elasticache - A method of caching commonly queried data from your server
  * Red Shift - Data warehousing, Business Intelligence - complex queries for reporting
* **Migration**
  * AWS Migration Hub - Tracking service for applications as they migrate, integrates with other services
  * Application Discovery Service - Automated tools that detect applications and dependencies
  * Database Migration Service - Easy way to migrate DBs from on-prem to AWS
  * Server Migration Service - Easy way to migrate virtual and physical servers to AWS
* +**Networking & Content Delivery**
  * +++VPC (Virtual Private Cloud) - Configure firewalls, AZs, route tables, etc.
  * CloudFront - Content Delivery Network
  * Route53 - Amazon's DNS Service w/ IPv4 and IPv6
  * +API Gateway - Create an API for any of your services to talk to
  * Direct Connect - Run a dedicated line from office/datacenter to an Amazon data center
* **Developer Tools**
  * CodeStar - Get a group of devs working together, project management of code - CI/CD toolchains, etc
  * CodeCommit - Source Control service - private git repositories, etc
  * CodeBuild - Compiles code, runs tests, producing deployable packages
  * CodeDeploy - Automates application deployment to EC2, On-Prem, and Lambda services
  * CodePipeline - CI/CD service used to model, visualize, and automate release
  * X-Ray - Debug and Analyze server-less applications
  * Cloud9 - AWS Console-based IDE
* +**Management Tools**
  * CloudWatch - Monitoring Service
  * CloudFormation - Way of scripting infrastructure (load balancers, firewalls, etc)
  * CloudTrail - Log of all actions and changes on an AWS environment, stores records for 1 week
  * Config - Monitors config of AWS environment, and point-in-time snapshots to see what it looks like
  * OpsWorks - Uses "Chef" and "Puppet" to automate configuration of environments
  * Service Catalog - Manages catalogues of IT services approved for use on AWS
  * Systems Manager - Interface for managing AWS Resources (EC2 patch maintenance, grouping resources, etc)
  * Trusted Advisor - Advice against multiple disciplines on what to fix and update, risk factors, money saving, etc.
  * Managed Services - Autoscaling and EC2 instance management handled for you.
* **Media Services**
  * Elastic Transcoder - Transcodes media for cross-device usage
  * MediaConvert - File-based video transcoding service for broadcast
  * MediaLive - Broadcast-grade live video processing
  * MediaPackage - Prepares/protects videos for delivery on internet
  * MediaStore - Storage service optimized for media
  * MediaTailor - Targeted advertising into videostreams with no sacrifice of quality
* **Machine Learning**
  * SageMaker - Easy use of Deep Learning for coding for environments
  * Comprehend - Sentiment Analysis on data
  * DeepLens - Artificially aware camera that figures out what it's looking at _on device_
  * Lex - Powers Amazon Alexa service.  AI method of chatting with customers
  * Machine Learning - Process datasets to find out if newly added data meets specific outcomes
  * Polly - Takes text and turns it into more natural-sounding speech
  * Rekognition - Video and Image recognition
  * Amazon Translate - Machine translation of languages
  * Amazon Transcribe - Automatic speech recognition and closed-captioning
* +**Analytics**
  * Athena - Run SQL queries against things in S3 buckets, completely serverless
  * Elastic Map Reduce (EMR) - Processing large amounts of data for analysis
  * CloudSearch & ElasticSearch - Search services for AWS
  * Kinesis - Ingest large amounts of data into AWS (social media feeds, tweets, hashtags, etc)
  * Kinesis Video Stream - Ingest streaming video data from mobile devices and process it
  * QuickSight - Business Intelligence tool
  * +Data Pipeline - A method of moving data between AWS services
  * Glue - Used for "ETL" (Extract, Transform, Load) - Reformat various data in different formats into specific formats
* +**Security & Identity & Compliance**
  * [+IAM (Identity Access Management)](services/IAM.md) - ???
  * Cognito - Method of doing device authentication for mobile access to AWS services
  * Guard Duty - Monitors for malicious activity on AWS accounts
  * +Inspector - Install on VMs, then run tests against it for security vulnerabilities, etc. with reporting
  * Macie - Scans S3 buckets and looks for Personally Identifiable Information (PII)
  * +Certificate Manager - SSL Certificate management
  * +CloudHSM - Hardware Security Module, a dedicated piece of hardware to store private/public keys, encryption keys, etc.
  * +Directory Service - A was of integrating Microsoft AD services into AWS
  * +WAF (Web Application Firewall) - Level 7 (Application) Layer firewall (XSS, SQL Injection, etc.)
  * +Shield - DDOS mitigation management, optional dedicated 24x7 team of people to help you
  * Artifact - Auditing and Compliance report management, SOC controls, PCI reports, etc
* **Mobile Services**
  * Mobile Hub - Management console for mobile app AWS instances
  * Pinpoint - Use targeted push notifications for mobile engagement
  * AppSync - Updates the data in web/mobile apps realtime, or for offline users as they reconnect
  * Device Farm - Test apps on real devices of all types
  * Mobile Analytics - Analytics service for mobile apps and devices
* **AR/VR**
  * Sumerian - Allows a common set of tool to create stuff in AR, VR and 3D environments
* +**Application Integration**
  * Step Functions - Method of managing Lambda functions
  * Amazon MQ - Message queues (like RabbitMQ)
  * +SNS (Simple Notification Service) - Notification service
  * +SQS (Simple Queue Service) - Decouple infrastructure, hold data in a queue for requesting of data from services
  * +SWF (Simple Workflow Service) - Adds human beings as a component to a workflow
* **Customer Engagement**
  * Connect - Contact Center as a Service; Natural, dynamic, and personal customer engagement, etc.
  * Simple Email Service - Email management; sending large amounts of email, cost effective, customizable
* **Business Productivity**
  * Alexa For Business - Dialing into meetings, informing IT of outages, reordering supplies, etc.
  * Chime - Video conferencing, recording, etc.
  * Work Docs - Dropbox-style storage and upload for AWS
  * WorkMail - Amazon's "Office 365" Email
* **Desktop & App Streaming**
  * Workspaces - VDI solution for AWS instances, run environment in cloud
  * AppStream 2.0 - Stream applications from the cloud to your devices
* **Internet of Things**
  * iOT - Handle tons of IoT data from tons of devices
  * iOT Device Management - Management of all the devices connected to your AWS instance
  * FreeRTOS - Operating system for micro-controllers
  * Greengrass - Software that runs local compute, messaging, data caching, sync, and ML capabilities securely
* **Game Development**
  * GameLift - Helps develop games hosted on AWS Cloud
