while getopts c:s: flag
do
    case "${flag}" in
        c) changedir=${OPTARG};;
        s) source=${OPTARG};;
    esac
done
echo "Dir: $changedir";
echo "Source: $source";

tar --exclude target --exclude dbt_modules --exclude logs --exclude .user.yml -C $changedir -czf $source.tar.gz $source/
