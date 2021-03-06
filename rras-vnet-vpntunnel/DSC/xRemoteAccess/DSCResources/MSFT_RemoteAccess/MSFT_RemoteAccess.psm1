function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[ValidateSet('Vpn','VpnS2S')]
		[System.String]
		$VpnType,

		[ValidateSet('Present','Absent')]
		[System.String]
		$Ensure = 'Present',

		[System.String]
		$EntrypointName
	)
    
    if ($EntrypointName) {
        $RemoteAccess = Get-RemoteAccess -EntrypointName $EntrypointName
        }
    else {
        $RemoteAccess = Get-RemoteAccess
        }

	$returnValue = @{
		Ensure = [System.String]$Ensure
		EntrypointName = [System.String]$EntrypointName
		VpnType = [System.String]$VpnType
        DAStatus = [System.String]$RemoteAccess.DAStatus
        VpnStatus = [System.String]$RemoteAccess.VpnStatus
        VpnS2SStatus = [System.String]$RemoteAccess.VpnS2SStatus
        SstpProxyStatus = [System.String]$RemoteAccess.SstpProxyStatus
        RoutingStatus = [System.String]$RemoteAccess.RoutingStatus
        LoadBalancing = [System.String]$RemoteAccess.LoadBalancing
        InternetInterface = [System.String]$RemoteAccess.InternetInterface
        InternalInterface = [System.String]$RemoteAccess.InternalInterface
        SslCertificate = [System.String]$RemoteAccess.SslCertificate
        IPAssignmentMethod = [System.String]$RemoteAccess.IPAssignmentMethod
        IPAddressRangeList = [System.String]$RemoteAccess.IPAddressRangeList
        IPv6Prefix = [System.String]$RemoteAccess.IPv6Prefix
        AuthenticationType = [System.String]$RemoteAccess.AuthenticationType
        RadiusServerList = [System.String]$RemoteAccess.RadiusServerList
	}

	$returnValue
}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[System.UInt64]
		$CapacityKbps,

		[System.String]
		$ClientGpoName,

		[System.String]
		$ConnectToAddress,

		[ValidateSet('FullInstall','ManageOut')]
		[System.String]
		$DAInstallType,

		[System.Boolean]
		$DeployNat,

		[ValidateSet('Present','Absent')]
		[System.String]
		$Ensure = 'Present',

		[System.String]
		$EntrypointName,

		[System.String[]]
		$IPAddressRange,

		[System.String]
		$IPv6Prefix,

		[System.String]
		$InternalInterface,

		[System.String]
		$InternetInterface,

		[ValidateSet('Enabled','Disabled')]
		[System.String]
		$MsgAuthenticator,

		[System.Boolean]
		$MultiTenancy,

		[System.String]
		$NlsCertificate,

		[System.String]
		$NlsUrl,

		[System.Boolean]
		$NoPrerequisite,

		[System.UInt16]
		$RadiusPort,

		[System.UInt16]
		$RadiusScore,

		[System.String]
		$RadiusServer,

		[System.UInt32]
		$RadiusTimeout,

		[System.String]
		$ServerGpoName,

		[System.String]
		$SharedSecret,

		[System.UInt32]
		$ThrottleLimit,

		[parameter(Mandatory = $true)]
		[ValidateSet('Vpn','VpnS2S')]
		[System.String]
		$VpnType
	)
    
    $Params = $PSBoundParameters
    $output = $Params.Remove('Ensure')
    $output = $Params.Remove('Debug')
    $output = $Params.Remove('Verbose')
    $output = $Params.Remove('DependsOn')

    if ($Ensure -eq 'Present') {
        Install-RemoteAccess @Params
    }
    if ($Ensure -eq 'Absent') {
        Uninstall-RemoteAccess
    }
}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[System.UInt64]
		$CapacityKbps,

		[System.String]
		$ClientGpoName,

		[System.String]
		$ConnectToAddress,

		[ValidateSet('FullInstall','ManageOut')]
		[System.String]
		$DAInstallType,

		[System.Boolean]
		$DeployNat,

		[ValidateSet('Present','Absent')]
		[System.String]
		$Ensure,

		[System.String]
		$EntrypointName,

		[System.String[]]
		$IPAddressRange,

		[System.String]
		$IPv6Prefix,

		[System.String]
		$InternalInterface,

		[System.String]
		$InternetInterface,

		[ValidateSet('Enabled','Disabled')]
		[System.String]
		$MsgAuthenticator,

		[System.Boolean]
		$MultiTenancy,

		[System.String]
		$NlsCertificate,

		[System.String]
		$NlsUrl,

		[System.Boolean]
		$NoPrerequisite,

		[System.UInt16]
		$RadiusPort,

		[System.UInt16]
		$RadiusScore,

		[System.String]
		$RadiusServer,

		[System.UInt32]
		$RadiusTimeout,

		[System.String]
		$ServerGpoName,

		[System.String]
		$SharedSecret,

		[System.UInt32]
		$ThrottleLimit,

		[parameter(Mandatory = $true)]
		[ValidateSet('Vpn','VpnS2S')]
		[System.String]
		$VpnType
	)

    $result = [System.Boolean]$false
    $RemoteAccess = Get-RemoteAccess
    Write-Debug $RemoteAccess
    
    # To validate configuration rather than deployment, this should test all properties

    if ($VpnType -eq 'Vpn') {
        $RemoteAccess = $RemoteAccess.VpnStatus -eq "Installed"
    }
    if ($VpnType -eq 'VpnS2S') {
        $RemoteAccess = $RemoteAccess.VpnS2SStatus -eq "Installed"
    }
    
    # If the module is expanded to cover additional scenarios, the checks should be ammended here following the same pattern if possible.
    

	if ($Ensure -eq 'Present' -and $RemoteAccess -eq $true) {
        $result = [System.Boolean]$true
    }
    if ($Ensure -eq 'Absent' -and $RemoteAccess -eq $false) {
        $result = [System.Boolean]$true
    }
	
	$result
}


Export-ModuleMember -Function *-TargetResource

