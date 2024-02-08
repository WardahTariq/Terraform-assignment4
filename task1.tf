
resource "aws_iam_user" "terraform_user" {
  name = "terraform-cs423-devops"
}

resource "aws_iam_access_key" "terraform_user_access_key" {
  user = aws_iam_user.terraform_user.name
  depends_on = [aws_iam_user.terraform_user]
}


resource "aws_iam_user_policy_attachment" "terraform_user_policy" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "pgp_key" "user_login_key" {
  name    = aws_iam_user.terraform_user.name
  email   = "wardabibi69@gmail.com"
  comment = "PGP Key"
}

resource "aws_iam_user_login_profile" "user_login" {
  user                    = aws_iam_user.terraform_user.name
  pgp_key                 = pgp_key.user_login_key.public_key_base64
  password_reset_required = false

  depends_on = [aws_iam_user.terraform_user, pgp_key.user_login_key]
}

data "pgp_decrypt" "user_password_decrypt" {

  ciphertext          = aws_iam_user_login_profile.user_login.encrypted_password
  ciphertext_encoding = "base64"
  private_key         = pgp_key.user_login_key.private_key
}

output "credentials" {
  value = {
      "key"      = aws_iam_access_key.terraform_user_access_key.id
      "secret"   = aws_iam_access_key.terraform_user_access_key.secret
      "password" = data.pgp_decrypt.user_password_decrypt.plaintext    
  }
  sensitive = true
  depends_on = [aws_iam_user.terraform_user,aws_iam_access_key.terraform_user_access_key]

}
