:

#stty erase ^H
if [ -z "$1" ]; then
  perl -pi -e 's/(^version[\s"]+)(\d+\.)(\d+\.)(\d+)(.)/"$1$2$3".($4+1)."$5"/e' metadata.rb
#  echo "Bumped version from $1$2$3"."$4 to $1$2$3".($4+1)."$5"
else
  echo "Not bumping version"
fi
echo -n "Commit Comment: "
read comment
git add -A
git commit -m "$comment"
git tag `perl -lne 'print $1 if /^version[\s"]+([\d\.]+)/' metadata.rb`
git push ; git push --tags
