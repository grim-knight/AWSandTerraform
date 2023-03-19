resource "aws_s3_bucket" "webbucket" {
  bucket = var.bucketName
}


resource "aws_s3_bucket_website_configuration" "webbucket-config" {
  bucket = aws_s3_bucket.webbucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "webbucket-policy" {
  bucket = aws_s3_bucket.webbucket.id
  policy = templatefile("s3-policy.json", { bucket = var.bucketName })
}

resource "aws_s3_object" "webbucket-index" {
  bucket = aws_s3_bucket.webbucket.id
  key    = "index.html"
  source = "../src/index.html"
  acl    = "public-read"
}
