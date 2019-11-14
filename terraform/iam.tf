resource "aws_iam_user" "hugo-bot" {
    Name = "hugo-bot"
}
esource "aws_iam_role" "hugo-ec2-role" {
    name = "hugo-ec2-role"
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
        Name = "hugo-ec2-role"
    }
}
resource "aws_iam_instance_profile" "hugo-ec2-role" {
    name = "hugo-ec2-role"
    role = "${aws_iam_role.hugo-ec2-role.name}"
}
resource "aws_iam_role_policy" "hugo-ec2-role-policy" {
    name = "hugo-ec2-role-policy"
    role = "${aws_iam_role.hugo-ec2-role.id}"
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

resource "aws_iam_role" "bastion-role" {
    name = "bastion-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    ]
}
EOF
    tags = {
        Name = "bastion-role"
    }
}
resource "aws_iam_instance_profile" "bastion-role" {
    name = "bastion-role"
    role = "${aws_iam_role.bastion-role.name}"
}
resource "aws_iam_role_policy" "bastion-role-policy" {
    name = "bastion-role-policy"
    role = "${aws_iam_role.bastion-role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    ]
}
EOF
}