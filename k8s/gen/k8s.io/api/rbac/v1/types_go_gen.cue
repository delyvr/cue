// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/rbac/v1

package v1

import metav1 "github.com/delyvr/cue/k8s/gen/k8s.io/apimachinery/pkg/apis/meta/v1"

#APIGroupAll:        "*"
#ResourceAll:        "*"
#VerbAll:            "*"
#NonResourceAll:     "*"
#GroupKind:          "Group"
#ServiceAccountKind: "ServiceAccount"
#UserKind:           "User"

// AutoUpdateAnnotationKey is the name of an annotation which prevents reconciliation if set to "false"
#AutoUpdateAnnotationKey: "rbac.authorization.kubernetes.io/autoupdate"

// PolicyRule holds information that describes a policy rule, but does not contain information
// about who the rule applies to or which namespace the rule applies to.
#PolicyRule: {
	// Verbs is a list of Verbs that apply to ALL the ResourceKinds and AttributeRestrictions contained in this rule.  VerbAll represents all kinds.
	verbs: [...string] @go(Verbs,[]string) @protobuf(1,bytes,rep)

	// APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of
	// the enumerated resources in any API group will be allowed.
	// +optional
	apiGroups?: [...string] @go(APIGroups,[]string) @protobuf(2,bytes,rep)

	// Resources is a list of resources this rule applies to.  ResourceAll represents all resources.
	// +optional
	resources?: [...string] @go(Resources,[]string) @protobuf(3,bytes,rep)

	// ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.
	// +optional
	resourceNames?: [...string] @go(ResourceNames,[]string) @protobuf(4,bytes,rep)

	// NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path
	// Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding.
	// Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both.
	// +optional
	nonResourceURLs?: [...string] @go(NonResourceURLs,[]string) @protobuf(5,bytes,rep)
}

// Subject contains a reference to the object or user identities a role binding applies to.  This can either hold a direct API object reference,
// or a value for non-objects such as user and group names.
#Subject: {
	// Kind of object being referenced. Values defined by this API group are "User", "Group", and "ServiceAccount".
	// If the Authorizer does not recognized the kind value, the Authorizer should report an error.
	kind: string @go(Kind) @protobuf(1,bytes,opt)

	// APIGroup holds the API group of the referenced subject.
	// Defaults to "" for ServiceAccount subjects.
	// Defaults to "rbac.authorization.k8s.io" for User and Group subjects.
	// +optional
	apiGroup?: string @go(APIGroup) @protobuf(2,bytes,opt.name=apiGroup)

	// Name of the object being referenced.
	name: string @go(Name) @protobuf(3,bytes,opt)

	// Namespace of the referenced object.  If the object kind is non-namespace, such as "User" or "Group", and this value is not empty
	// the Authorizer should report an error.
	// +optional
	namespace?: string @go(Namespace) @protobuf(4,bytes,opt)
}

// RoleRef contains information that points to the role being used
#RoleRef: {
	// APIGroup is the group for the resource being referenced
	apiGroup: string @go(APIGroup) @protobuf(1,bytes,opt)

	// Kind is the type of resource being referenced
	kind: string @go(Kind) @protobuf(2,bytes,opt)

	// Name is the name of resource being referenced
	name: string @go(Name) @protobuf(3,bytes,opt)
}

// Role is a namespaced, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding.
#Role: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Rules holds all the PolicyRules for this Role
	// +optional
	rules: [...#PolicyRule] @go(Rules,[]PolicyRule) @protobuf(2,bytes,rep)
}

// RoleBinding references a role, but does not contain it.  It can reference a Role in the same namespace or a ClusterRole in the global namespace.
// It adds who information via Subjects and namespace information by which namespace it exists in.  RoleBindings in a given
// namespace only have effect in that namespace.
#RoleBinding: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Subjects holds references to the objects the role applies to.
	// +optional
	subjects?: [...#Subject] @go(Subjects,[]Subject) @protobuf(2,bytes,rep)

	// RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace.
	// If the RoleRef cannot be resolved, the Authorizer must return an error.
	roleRef: #RoleRef @go(RoleRef) @protobuf(3,bytes,opt)
}

// RoleBindingList is a collection of RoleBindings
#RoleBindingList: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is a list of RoleBindings
	items: [...#RoleBinding] @go(Items,[]RoleBinding) @protobuf(2,bytes,rep)
}

// RoleList is a collection of Roles
#RoleList: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is a list of Roles
	items: [...#Role] @go(Items,[]Role) @protobuf(2,bytes,rep)
}

// ClusterRole is a cluster level, logical grouping of PolicyRules that can be referenced as a unit by a RoleBinding or ClusterRoleBinding.
#ClusterRole: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Rules holds all the PolicyRules for this ClusterRole
	// +optional
	rules: [...#PolicyRule] @go(Rules,[]PolicyRule) @protobuf(2,bytes,rep)

	// AggregationRule is an optional field that describes how to build the Rules for this ClusterRole.
	// If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be
	// stomped by the controller.
	// +optional
	aggregationRule?: null | #AggregationRule @go(AggregationRule,*AggregationRule) @protobuf(3,bytes,opt)
}

// AggregationRule describes how to locate ClusterRoles to aggregate into the ClusterRole
#AggregationRule: {
	// ClusterRoleSelectors holds a list of selectors which will be used to find ClusterRoles and create the rules.
	// If any of the selectors match, then the ClusterRole's permissions will be added
	// +optional
	clusterRoleSelectors?: [...metav1.#LabelSelector] @go(ClusterRoleSelectors,[]metav1.LabelSelector) @protobuf(1,bytes,rep)
}

// ClusterRoleBinding references a ClusterRole, but not contain it.  It can reference a ClusterRole in the global namespace,
// and adds who information via Subject.
#ClusterRoleBinding: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Subjects holds references to the objects the role applies to.
	// +optional
	subjects?: [...#Subject] @go(Subjects,[]Subject) @protobuf(2,bytes,rep)

	// RoleRef can only reference a ClusterRole in the global namespace.
	// If the RoleRef cannot be resolved, the Authorizer must return an error.
	roleRef: #RoleRef @go(RoleRef) @protobuf(3,bytes,opt)
}

// ClusterRoleBindingList is a collection of ClusterRoleBindings
#ClusterRoleBindingList: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is a list of ClusterRoleBindings
	items: [...#ClusterRoleBinding] @go(Items,[]ClusterRoleBinding) @protobuf(2,bytes,rep)
}

// ClusterRoleList is a collection of ClusterRoles
#ClusterRoleList: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is a list of ClusterRoles
	items: [...#ClusterRole] @go(Items,[]ClusterRole) @protobuf(2,bytes,rep)
}
