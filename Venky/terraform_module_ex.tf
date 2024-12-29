1. Create a terraform project (ex: devops) folder.
2. In it, create a file (ex: provider.tf) and write the below code in it.
provider "aws" {
  region = "us-east-1"
}

1. create a folder named "modules" in our terraform project (ex: devops)
2. In it create a folder (ex: mymodule).
3. create a file in it (ex: vpc.tf) and write the below code to create VPC

resource "aws_vpc" "main" {
  cidr_block = "10.2.3.0/24"
}

4. Now call this module (mymodule) into above "provider.tf" file. so the final provider.tf file will be:

provider "aws" {
  region = "us-east-1"
}
module "myVPCmodule" {
  source = "./modules/myVPCmodule"
}
