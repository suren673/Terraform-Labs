apt update
  apt install -y apache2
  cat <<EOF > /var/www/html/index.html
  <html><body>
  <h2>Welcome to your custom website.</h2>
  <h3>Created with a direct input startup script!</h3>
  </body></html>
  EOF
