# Notes to enable policy assignments

This branch contains sample code to demonstrate the following:

* Creation of a custom policy set ``Enforce-Mandatory-Tags`` (policy initiative) from three instances of the builtin Azure policy [Require Tag on Resources](https://www.azadvertizer.net/azpolicyadvertizer/871b6d14-10aa-478d-b590-94f262ecfa99.html) and placement in the ALZ root management group.
* Application of that custom policy to the root management group.
* Application of the builtin Azure policy [Allowed Locations](https://www.azadvertizer.net/azpolicyadvertizer/e56962a6-4747-49cd-b67b-bf8b01975c4c.html) to the root management group.
* Addition of tags and values to the ALZ resources created that adhere to the ``Enforce-Mandatory-Tags`` policy set in ``terraform.tfvars``.
* Addition of the necessary changes to the override file ``./lib/archetype_definitions/root_custom.alz_archetype_override.yaml``

To implement uncomment the lines that are noted in the following files:

* ``./lib/archetype_definitions/root_custom.alz_archetype_override.yaml`` (lines ``5,6,14``)
* ``./terraform.tfvars`` (lines ``322-324``)

