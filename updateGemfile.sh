VERSION=$(gem search -e eyes_selenium | grep eyes_selenium | grep -E -o "\d+.\d+.\d+")
echo $VERSION
bundle remove eyes_selenium && bundle add eyes_selenium -v "$VERSION"