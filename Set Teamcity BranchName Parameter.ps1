Param(
    [string] $fullBranchName = "refs/heads/master"
)

$branch = $fullBranchName
if ($branch.StartsWith("refs/heads/feature_")){
    $branch = $branch.Split('_'.ToCharArray(), 2)[1]
}


if ($branch.StartsWith("refs/heads/")){
    $branch = $branch.Substring("refs/heads/".Length)
}

$branch = $branch.Replace("/", "_")

if ($branch.StartsWith("feature_")){
    $branch = $branch.Split('_'.ToCharArray(), 2)[1]
}



write-host "##teamcity[setParameter name='system.BranchName' value='$branch']"
