echo "=== Compression ==="
sudo btrfs filesystem defragment -r -v -czstd --level 15 /
sudo btrfs filesystem defragment -r -v -czstd --level 15 /home
sudo btrfs filesystem defragment -r -v -czstd --level 15 /var
sudo btrfs filesystem defragment -r -v -czstd --level 15 /.snapshots
echo "=== Deduplication ==="
sudo duperemove -drh /
