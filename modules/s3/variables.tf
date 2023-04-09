variable "pub_S3_files_to_upload" {
  type = map(string)
  default = {
    "web_content/index.html" = "text/html",
    "web_content/scripts.js" = "application/javascript"
    "web_content/styles.css" = "text/css"
  }
}

variable "private_S3_files_to_upload" {
  type = map(string)
  default = {
    "web_content/patches1.jpg" = "image/jpeg",
    "web_content/patches2.jpg" = "image/jpeg",
    "web_content/patches3.jpg" = "image/jpeg",
  }
}

