I've just been working on an AWS cloudformation stack which sets up the infrastructure for my project. I usually deploy the stack to `eu-west-1` but this time, we're testing some multi-region functionality so I was launching into `us-east-1`.

To cut a long story short, my AWS cloudformation stack kept bombing out with an error message:

> "The availability zones of the specified subnets and the AutoScalingGroup do not match"

Hmmm...that's a bit cryptic. So, I had a look through my ASG (auto-scaling group) cloudformation config and saw nothing unusual, just the standard:

```
"Properties":
{
  "AvailabilityZones":{ "Fn::GetAZs" : { "Ref" : "AWS::Region" } },
  "VPCZoneIdentifier":
  [
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet0" ]},
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet1" ]},
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet2" ]}
  ],
...
```

That's the same as I use in `eu-west-1` with no troubles.

Most AWS regions have 3 AZ's (availablility zones) so my "core-infrastructure" cloudformation script has allowance for just 3 AZs, into each of which it creates a subnet. I wondered if perhaps `us-east-1` had more or less that 3 AZ's, I was suspecting more as the error messages on AWS when items are missing are usually a little clearer that this.

It turns out that `us-east-1` does indeed have more AZ's, 4 in fact - oddly enough, for me at least, they're labelled `1a`, `1b`, `1c` and `1e` - no idea what happpened to `1d`.

So the fix is super simple, I just had to create a subnet for AZ `1e` (luckily my VPC had just enough space in it's range for another /21 subnet) and then amend the ASG config my stack above to:

```
"Properties":
{
  "AvailabilityZones":{ "Fn::GetAZs" : { "Ref" : "AWS::Region" } },
  "VPCZoneIdentifier":
  [
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet0" ]},
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet1" ]},
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet2" ]},
    {"Fn::FindInMap" : [ "subnetIDRegionMap", { "Ref" : "AWS::Region" }, "publicSubnet3" ]}
  ],
...
```

Easy! The stack then builds successfully.

So the error comes from my specifying:

```
"AvailabilityZones":{ "Fn::GetAZs" : { "Ref" : "AWS::Region" } }
```

Which essentially tells cloudformation to build the ASG across all 4 AZs and since I was supplying only 3 subnets, the AZ set didn't match the subnets provided. So the error message makes sense...once you know/realise that!