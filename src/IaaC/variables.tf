
# tokens, api keys

variable "csDownloadUrl" { #URL to a password protected Cobalt Strike zip
    default = "127.0.0.1"
}

variable "cspw" {
    default = "my_password"}

variable "csuser" {
    default = "my_user"}




variable "do-tokens"{
    default = "XXXX"}

variable "do-api-key"{
    default = "XXXX"}

variable "ami" {
  type    = string
  default = "ami-0194c3e07668a7e36"
}

variable "private_key" {
  type    = string
  default = "deployment.pem"
}

variable "whitelist_cidr" {
  type    = string
  default = "1.2.3.4/32"
}