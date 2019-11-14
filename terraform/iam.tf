resource "aws_iam_role" "ec2-role" {
    name = "ec2-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
            "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
    tags = {
        Name = "ec2-role"
    }
}
resource "aws_iam_instance_profile" "ec2-role" {
    name = "ec2-role"
    role = "${aws_iam_role.ec2-role.name}"
}
resource "aws_iam_role_policy" "ec2-role-policy" {
    name = "ec2-role-policy"
    role = "${aws_iam_role.ec2-role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::cit480mars",
                "arn:aws:s3:::cit480mars/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
EOF
}