## Firstly we need to create a Role that have policies assigned to it
## We can then create a policy
## Lastly we need an Instance Profile to assign the role to the instance


# Create an IAM Role
resource "aws_iam_role" "web_role" {
  name = "web_role"
  assume_role_policy = file("webbucketrole.json") # Naturally we woulc narrow the policy down to only access the particular bucket using a ARN
}

# Create the Policy for the Role
resource "aws_iam_role_policy" "web_policy" {
  name        = "webAccess"
  role = aws_iam_role.web_role.id
  policy      = file("webbucketpolicy.json") # Naturally we woulc narrow the policy down to only access the particular bucket using a ARN
}
# Create an IAM Instance Profile (allow us to attach a role to an EC2 Instance)
resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "web_instance_profile"
  role = aws_iam_role.web_role.name
}



