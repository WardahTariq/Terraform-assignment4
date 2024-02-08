terraform {
  required_providers {
    pgp = {
      source = "ekristen/pgp"
    }
     aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"    
}    

}
}


provider "aws" {
  region = "us-east-1"
}
