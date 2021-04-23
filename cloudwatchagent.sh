#! /bin/bash
apt-get -y install wget zip # just in case!
INSTALLDIR="/tmp/cloudwatchinstall"
mkdir $INSTALLDIR
cd $INSTALLDIR
wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
unzip AmazonCloudWatchAgent.zip
./install.sh
echo '{
  "agent": {
      "metrics_collection_interval": 60,
      "run_as_user": "cwagent"
  },
  "metrics": {
      "append_dimensions": {
        "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
        "ImageId": "${aws:ImageId}",
        "InstanceId": "${aws:InstanceId}",
        "InstanceType": "${aws:InstanceType}"
      },
      "metrics_collected": {
        "disk": {
          "measurement": [
            "used_percent"
        ],
        "metrics_collection_interval": 60,
          "resources": [
              "*"
        ]
      },
      "mem": {
          "measurement": [
            "mem_used_percent"
          ],
          "metrics_collection_interval": 60
      }
    }
  }
}' > $INSTALLDIR/config.json

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/$INSTALLDIR/config.json -s