VERSION=$(gem search -e eyes_selenium | grep eyes_selenium | grep -E -o "\d+.\d+.\d+")
bundle remove eyes_selenium && bundle add eyes_selenium -v "$VERSION"