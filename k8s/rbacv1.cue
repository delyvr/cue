
// Code generated by generate.go. DO NOT EDIT.
package k8s

import (
	kube "github.com/delyvr/cue/k8s/gen/k8s.io/api/rbac/v1"
)


rbac: v1:  #Role: kube.#Role
rbac: v1:  #Role: {
	Kind: "Role"
	apiVersion: "rbac/v1"
}

rbac: v1:  #RoleBinding: kube.#RoleBinding
rbac: v1:  #RoleBinding: {
	Kind: "RoleBinding"
	apiVersion: "rbac/v1"
}

rbac: v1:  #ClusterRole: kube.#ClusterRole
rbac: v1:  #ClusterRole: {
	Kind: "ClusterRole"
	apiVersion: "rbac/v1"
}

rbac: v1:  #ClusterRoleBinding: kube.#ClusterRoleBinding
rbac: v1:  #ClusterRoleBinding: {
	Kind: "ClusterRoleBinding"
	apiVersion: "rbac/v1"
}
