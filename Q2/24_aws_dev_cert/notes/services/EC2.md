# Elastic Compute Cloud (EC2)
## What is it?
* Provides resizable compute capacity in the cloud
* Reduces the time to obtain/boot new servers in minutes
* Allows scaling of capacity depending on requirements
* You pay only for the capacity you use, instead of over-provisioning

### EC2 Options
1. **On Demand:** allows you to pay a fixed by-the-hour or by-the-second rate with no commitment
  * Perfect for users who want low-cost and flexible instances w/o long-term commitments or down payments
  * Application with short-term, spiky, or unpredictable workloads that can't be interrupted
  * Applications developed or tested on EC2 for the first time
2. **Reserved Instances:** provides you with a capacity reservation @ discount, 1-3 year terms
  * Applications with steady state or predictable usage
  * Applications that require reserved capacity
  * Users can make up-front payments to reduce total computing costs even further
    * Standard RIs (up to 75% off from On-Demand cost)
    * Convertible RIs (up to 54% off from On-Demand cost)
      * Capability to change the attributes of the RI as long as the exchange results in the creation of RIs of >= value
    * Scheduled RIs
      * Launch with a time window you reserve, allowing you to match capacity with a predictable schedule that might only required a fraction of a day/week/month
3. **Spot:** allows you to bid for a price for instant capacity, if your app has flexible start/end times
  * Applications that are only feasible at very low compute prices
    * Genomes, Pharmaceuticals, Chemical companies, etc.
    * Useful for large computing projects at, say 2am on a Sunday
    * Users with an urgent need for large amounts of additional computing capacity
  * If this is terminated by Amazon EC2, you are not charged for a partial hour of usage
    * If you terminate it _yourself_, you _will_ be charged for the complete hour
4. **Dedicated Hosts:** Physical EC2 servers dedicated for your use, helping reduce costs allowing you to use existing server-bound licenses
  * Useful for regulatory requirements that may not support multi-tenant virtualization
    * Medical fields, PII leakage, etc
  * Great for licensing that does not support multi-tenant or cloud deployments
  * Can be purchased On-Demand (hourly)
  * Can be purchased as an RI for up to 70% off the On-Demand price

### EC2 Instance Types
Family | Specialty | Use Cases
--- | --- | ---
F1 | Field Programmable Gate Array | Genomics, financial analytics, real-time video processing, big data
I3 | High-Speed Storage | NoSQL DB, Data Warehousing
G3 | Graphics Intensive | Video Encoding, 3D Application streaming
H1 | High Disk Throughput | MapReduce workloads, Distributed FileSystems
T2 | Lowest Cost, General Purpose | Web Servers, Small DBs
D2 | Dense Storage | Fileservers, Data Warehousing, Hadoop
R4 | Memory Optimized | Memory-Intensive Apps and DBs
M5 | General Purpose | Application Servers
C5 | Compute Optimized | CPU-Intensive Apps and DBs
P3 | Graphics/General Purpose CPU | Machine Learning, Bitcoin Mining
X1 | Memory Optimized | SAP HANA, Apache Spark

#### How to remember the types:
**Fight DrMcPx**
* F for FPGA
* I for IOPS
* G for Graphics
* H for High Disk Throughput
* T for Totally Cheap
* D for Density
* R for RAM
* M for Main choice for general purpose apps
* C for Compute
* P for Pics (Graphics)
* X for X-treme Memory

### EBS
#### What is it?
* EBS allows you to create storage volumes to attach to EC2 instances, then create a filesystem on top of these volumes.
* Placed in specific Availability Zones and automatically replicated across multiple disks

#### Types:
1. General Purpose SSD (GP2)
  * General purpose, balances both price and performance
  * Ratio of 3 IOPS/GB with up to 10,000 IOPS and the ability to burst up to 3,000 IOPS for extended periods of time for 3,334 GiB and above volumes
2. Provisioned IOPS SSD (IO1)
  * Designed for I/O intensive apps such as NoSQL DBs
  * Use if you need _more than 10,000 IOPS_
  * Can provision up to 20,000 IOPS per volume
3. Throughput Optimized HDD (ST1)
  * Big Data
  * Data warehousing
  * _Cannot be a boot volume_
4. Cold HDD (SC1)
  * Lowest cost storage for infrequently accessed workloads
  * File Server
  * Cannot be a boot volume
5. Magnetic (Standard)
  * Lowest costs per GB of all EBS volume types _that is bootable_.  
  * Magnetic volumes are ideal for workloads where data is accessed infrequently
  * Applications where the lowest storage cost is important

### Exam Tips
1. 4 different pricing models (_EC2 Options_)
2. FIGHT DR MC PX
3. EBS Types
