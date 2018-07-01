// Define a provider for resources, giving credentials
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

// New resource for the S3 bucket our application will use.
# resource "aws_s3_bucket" "bucky" {
#   // NOTE: S3 bucket names must be unique across _all_ AWS accounts
#   bucket = "terraform-getting-started-guide"
#   acl    = "private"
# }

// Define a resource with `resource "{provider}_{resource-type}" "{resource-name}"`
resource "aws_instance" "example" {
  // Use `lookup` to check the variable map in the variables file
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  // Tells Terraform that this EC2 instance must be created only after the S3 bucket has been created.
  # depends_on    = ["${aws_s3_bucket.bucky}"]
  // PROVISIONERS
  provisioner "local-exec" {
    // Stores the IP Address of the AWS Instance in a text file locally
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

// Add an Elastic IP to the AWS instance!
resource "aws_eip" "ip" {
  // Doing this creates an "implicit dependency" between this resource and the "example" resource
  // Terraform uses this to decide the order to initiate the resources in
  // This is called "dependency by interpolation", and is the RECOMMENDED way to do this.
  instance = "${aws_instance.example.id}"
}

// Because THIS instance doesn't depend on any of the resources above, it can be
// created in PARALLEL with the "example" instance!
// NOTE:  We don't want to use this in the Terraform tutorial, so it's commented out
# resource "aws_instance" "another" {
#   ami           = "ami-b374d5a5"
#   instance_type = "t2.micro"
# }
