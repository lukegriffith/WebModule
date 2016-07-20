using Namespace System.Net;
using Namespace System.Management.Automation;
using Namespace System.Management.Automation.Runspaces;
using Namespace System.Collections.Generic;

Import-Module WebServer

$module = Get-Module WebServer


InModuleScope WebServer {

}