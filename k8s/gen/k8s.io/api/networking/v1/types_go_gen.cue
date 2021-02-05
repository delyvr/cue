// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/networking/v1

package v1

import (
	metav1 "github.com/delyvr/cue/k8s/gen/k8s.io/apimachinery/pkg/apis/meta/v1"
	"github.com/delyvr/cue/k8s/gen/k8s.io/api/core/v1"
	"github.com/delyvr/cue/k8s/gen/k8s.io/apimachinery/pkg/util/intstr"
)

// NetworkPolicy describes what network traffic is allowed for a set of Pods
#NetworkPolicy: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Specification of the desired behavior for this NetworkPolicy.
	// +optional
	spec?: #NetworkPolicySpec @go(Spec) @protobuf(2,bytes,opt)
}

// PolicyType string describes the NetworkPolicy type
// This type is beta-level in 1.8
#PolicyType: string // #enumPolicyType

#enumPolicyType:
	#PolicyTypeIngress |
	#PolicyTypeEgress

// PolicyTypeIngress is a NetworkPolicy that affects ingress traffic on selected pods
#PolicyTypeIngress: #PolicyType & "Ingress"

// PolicyTypeEgress is a NetworkPolicy that affects egress traffic on selected pods
#PolicyTypeEgress: #PolicyType & "Egress"

// NetworkPolicySpec provides the specification of a NetworkPolicy
#NetworkPolicySpec: {
	// Selects the pods to which this NetworkPolicy object applies. The array of
	// ingress rules is applied to any pods selected by this field. Multiple network
	// policies can select the same set of pods. In this case, the ingress rules for
	// each are combined additively. This field is NOT optional and follows standard
	// label selector semantics. An empty podSelector matches all pods in this
	// namespace.
	podSelector: metav1.#LabelSelector @go(PodSelector) @protobuf(1,bytes,opt)

	// List of ingress rules to be applied to the selected pods. Traffic is allowed to
	// a pod if there are no NetworkPolicies selecting the pod
	// (and cluster policy otherwise allows the traffic), OR if the traffic source is
	// the pod's local node, OR if the traffic matches at least one ingress rule
	// across all of the NetworkPolicy objects whose podSelector matches the pod. If
	// this field is empty then this NetworkPolicy does not allow any traffic (and serves
	// solely to ensure that the pods it selects are isolated by default)
	// +optional
	ingress?: [...#NetworkPolicyIngressRule] @go(Ingress,[]NetworkPolicyIngressRule) @protobuf(2,bytes,rep)

	// List of egress rules to be applied to the selected pods. Outgoing traffic is
	// allowed if there are no NetworkPolicies selecting the pod (and cluster policy
	// otherwise allows the traffic), OR if the traffic matches at least one egress rule
	// across all of the NetworkPolicy objects whose podSelector matches the pod. If
	// this field is empty then this NetworkPolicy limits all outgoing traffic (and serves
	// solely to ensure that the pods it selects are isolated by default).
	// This field is beta-level in 1.8
	// +optional
	egress?: [...#NetworkPolicyEgressRule] @go(Egress,[]NetworkPolicyEgressRule) @protobuf(3,bytes,rep)

	// List of rule types that the NetworkPolicy relates to.
	// Valid options are "Ingress", "Egress", or "Ingress,Egress".
	// If this field is not specified, it will default based on the existence of Ingress or Egress rules;
	// policies that contain an Egress section are assumed to affect Egress, and all policies
	// (whether or not they contain an Ingress section) are assumed to affect Ingress.
	// If you want to write an egress-only policy, you must explicitly specify policyTypes [ "Egress" ].
	// Likewise, if you want to write a policy that specifies that no egress is allowed,
	// you must specify a policyTypes value that include "Egress" (since such a policy would not include
	// an Egress section and would otherwise default to just [ "Ingress" ]).
	// This field is beta-level in 1.8
	// +optional
	policyTypes?: [...#PolicyType] @go(PolicyTypes,[]PolicyType) @protobuf(4,bytes,rep,casttype=PolicyType)
}

// NetworkPolicyIngressRule describes a particular set of traffic that is allowed to the pods
// matched by a NetworkPolicySpec's podSelector. The traffic must match both ports and from.
#NetworkPolicyIngressRule: {
	// List of ports which should be made accessible on the pods selected for this
	// rule. Each item in this list is combined using a logical OR. If this field is
	// empty or missing, this rule matches all ports (traffic not restricted by port).
	// If this field is present and contains at least one item, then this rule allows
	// traffic only if the traffic matches at least one port in the list.
	// +optional
	ports?: [...#NetworkPolicyPort] @go(Ports,[]NetworkPolicyPort) @protobuf(1,bytes,rep)

	// List of sources which should be able to access the pods selected for this rule.
	// Items in this list are combined using a logical OR operation. If this field is
	// empty or missing, this rule matches all sources (traffic not restricted by
	// source). If this field is present and contains at least one item, this rule
	// allows traffic only if the traffic matches at least one item in the from list.
	// +optional
	from?: [...#NetworkPolicyPeer] @go(From,[]NetworkPolicyPeer) @protobuf(2,bytes,rep)
}

// NetworkPolicyEgressRule describes a particular set of traffic that is allowed out of pods
// matched by a NetworkPolicySpec's podSelector. The traffic must match both ports and to.
// This type is beta-level in 1.8
#NetworkPolicyEgressRule: {
	// List of destination ports for outgoing traffic.
	// Each item in this list is combined using a logical OR. If this field is
	// empty or missing, this rule matches all ports (traffic not restricted by port).
	// If this field is present and contains at least one item, then this rule allows
	// traffic only if the traffic matches at least one port in the list.
	// +optional
	ports?: [...#NetworkPolicyPort] @go(Ports,[]NetworkPolicyPort) @protobuf(1,bytes,rep)

	// List of destinations for outgoing traffic of pods selected for this rule.
	// Items in this list are combined using a logical OR operation. If this field is
	// empty or missing, this rule matches all destinations (traffic not restricted by
	// destination). If this field is present and contains at least one item, this rule
	// allows traffic only if the traffic matches at least one item in the to list.
	// +optional
	to?: [...#NetworkPolicyPeer] @go(To,[]NetworkPolicyPeer) @protobuf(2,bytes,rep)
}

// NetworkPolicyPort describes a port to allow traffic on
#NetworkPolicyPort: {
	// The protocol (TCP, UDP, or SCTP) which traffic must match. If not specified, this
	// field defaults to TCP.
	// +optional
	protocol?: null | v1.#Protocol @go(Protocol,*v1.Protocol) @protobuf(1,bytes,opt,casttype=k8s.io/api/core/v1.Protocol)

	// The port on the given protocol. This can either be a numerical or named
	// port on a pod. If this field is not provided, this matches all port names and
	// numbers.
	// If present, only traffic on the specified protocol AND port will be matched.
	// +optional
	port?: null | intstr.#IntOrString @go(Port,*intstr.IntOrString) @protobuf(2,bytes,opt)

	// If set, indicates that the range of ports from port to endPort, inclusive,
	// should be allowed by the policy. This field cannot be defined if the port field
	// is not defined or if the port field is defined as a named (string) port.
	// The endPort must be equal or greater than port.
	// This feature is in Alpha state and should be enabled using the Feature Gate
	// "NetworkPolicyEndPort".
	// +optional
	endPort?: null | int32 @go(EndPort,*int32) @protobuf(3,bytes,opt)
}

// IPBlock describes a particular CIDR (Ex. "192.168.1.1/24","2001:db9::/64") that is allowed
// to the pods matched by a NetworkPolicySpec's podSelector. The except entry describes CIDRs
// that should not be included within this rule.
#IPBlock: {
	// CIDR is a string representing the IP Block
	// Valid examples are "192.168.1.1/24" or "2001:db9::/64"
	cidr: string @go(CIDR) @protobuf(1,bytes)

	// Except is a slice of CIDRs that should not be included within an IP Block
	// Valid examples are "192.168.1.1/24" or "2001:db9::/64"
	// Except values will be rejected if they are outside the CIDR range
	// +optional
	except?: [...string] @go(Except,[]string) @protobuf(2,bytes,rep)
}

// NetworkPolicyPeer describes a peer to allow traffic to/from. Only certain combinations of
// fields are allowed
#NetworkPolicyPeer: {
	// This is a label selector which selects Pods. This field follows standard label
	// selector semantics; if present but empty, it selects all pods.
	//
	// If NamespaceSelector is also set, then the NetworkPolicyPeer as a whole selects
	// the Pods matching PodSelector in the Namespaces selected by NamespaceSelector.
	// Otherwise it selects the Pods matching PodSelector in the policy's own Namespace.
	// +optional
	podSelector?: null | metav1.#LabelSelector @go(PodSelector,*metav1.LabelSelector) @protobuf(1,bytes,opt)

	// Selects Namespaces using cluster-scoped labels. This field follows standard label
	// selector semantics; if present but empty, it selects all namespaces.
	//
	// If PodSelector is also set, then the NetworkPolicyPeer as a whole selects
	// the Pods matching PodSelector in the Namespaces selected by NamespaceSelector.
	// Otherwise it selects all Pods in the Namespaces selected by NamespaceSelector.
	// +optional
	namespaceSelector?: null | metav1.#LabelSelector @go(NamespaceSelector,*metav1.LabelSelector) @protobuf(2,bytes,opt)

	// IPBlock defines policy on a particular IPBlock. If this field is set then
	// neither of the other fields can be.
	// +optional
	ipBlock?: null | #IPBlock @go(IPBlock,*IPBlock) @protobuf(3,bytes,rep)
}

// NetworkPolicyList is a list of NetworkPolicy objects.
#NetworkPolicyList: {
	metav1.#TypeMeta

	// Standard list metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is a list of schema objects.
	items: [...#NetworkPolicy] @go(Items,[]NetworkPolicy) @protobuf(2,bytes,rep)
}

// Ingress is a collection of rules that allow inbound connections to reach the
// endpoints defined by a backend. An Ingress can be configured to give services
// externally-reachable urls, load balance traffic, terminate SSL, offer name
// based virtual hosting etc.
#Ingress: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Spec is the desired state of the Ingress.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #IngressSpec @go(Spec) @protobuf(2,bytes,opt)

	// Status is the current state of the Ingress.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	status?: #IngressStatus @go(Status) @protobuf(3,bytes,opt)
}

// IngressList is a collection of Ingress.
#IngressList: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is the list of Ingress.
	items: [...#Ingress] @go(Items,[]Ingress) @protobuf(2,bytes,rep)
}

// IngressSpec describes the Ingress the user wishes to exist.
#IngressSpec: {
	// IngressClassName is the name of the IngressClass cluster resource. The
	// associated IngressClass defines which controller will implement the
	// resource. This replaces the deprecated `kubernetes.io/ingress.class`
	// annotation. For backwards compatibility, when that annotation is set, it
	// must be given precedence over this field. The controller may emit a
	// warning if the field and annotation have different values.
	// Implementations of this API should ignore Ingresses without a class
	// specified. An IngressClass resource may be marked as default, which can
	// be used to set a default value for this field. For more information,
	// refer to the IngressClass documentation.
	// +optional
	ingressClassName?: null | string @go(IngressClassName,*string) @protobuf(4,bytes,opt)

	// DefaultBackend is the backend that should handle requests that don't
	// match any rule. If Rules are not specified, DefaultBackend must be specified.
	// If DefaultBackend is not set, the handling of requests that do not match any
	// of the rules will be up to the Ingress controller.
	// +optional
	defaultBackend?: null | #IngressBackend @go(DefaultBackend,*IngressBackend) @protobuf(1,bytes,opt)

	// TLS configuration. Currently the Ingress only supports a single TLS
	// port, 443. If multiple members of this list specify different hosts, they
	// will be multiplexed on the same port according to the hostname specified
	// through the SNI TLS extension, if the ingress controller fulfilling the
	// ingress supports SNI.
	// +listType=atomic
	// +optional
	tls?: [...#IngressTLS] @go(TLS,[]IngressTLS) @protobuf(2,bytes,rep)

	// A list of host rules used to configure the Ingress. If unspecified, or
	// no rule matches, all traffic is sent to the default backend.
	// +listType=atomic
	// +optional
	rules?: [...#IngressRule] @go(Rules,[]IngressRule) @protobuf(3,bytes,rep)
}

// IngressTLS describes the transport layer security associated with an Ingress.
#IngressTLS: {
	// Hosts are a list of hosts included in the TLS certificate. The values in
	// this list must match the name/s used in the tlsSecret. Defaults to the
	// wildcard host setting for the loadbalancer controller fulfilling this
	// Ingress, if left unspecified.
	// +listType=atomic
	// +optional
	hosts?: [...string] @go(Hosts,[]string) @protobuf(1,bytes,rep)

	// SecretName is the name of the secret used to terminate TLS traffic on
	// port 443. Field is left optional to allow TLS routing based on SNI
	// hostname alone. If the SNI host in a listener conflicts with the "Host"
	// header field used by an IngressRule, the SNI host is used for termination
	// and value of the Host header is used for routing.
	// +optional
	secretName?: string @go(SecretName) @protobuf(2,bytes,opt)
}

// IngressStatus describe the current state of the Ingress.
#IngressStatus: {
	// LoadBalancer contains the current status of the load-balancer.
	// +optional
	loadBalancer?: v1.#LoadBalancerStatus @go(LoadBalancer) @protobuf(1,bytes,opt)
}

// IngressRule represents the rules mapping the paths under a specified host to
// the related backend services. Incoming requests are first evaluated for a host
// match, then routed to the backend associated with the matching IngressRuleValue.
#IngressRule: {
	// Host is the fully qualified domain name of a network host, as defined by RFC 3986.
	// Note the following deviations from the "host" part of the
	// URI as defined in RFC 3986:
	// 1. IPs are not allowed. Currently an IngressRuleValue can only apply to
	//    the IP in the Spec of the parent Ingress.
	// 2. The `:` delimiter is not respected because ports are not allowed.
	//   Currently the port of an Ingress is implicitly :80 for http and
	//   :443 for https.
	// Both these may change in the future.
	// Incoming requests are matched against the host before the
	// IngressRuleValue. If the host is unspecified, the Ingress routes all
	// traffic based on the specified IngressRuleValue.
	//
	// Host can be "precise" which is a domain name without the terminating dot of
	// a network host (e.g. "foo.bar.com") or "wildcard", which is a domain name
	// prefixed with a single wildcard label (e.g. "*.foo.com").
	// The wildcard character '*' must appear by itself as the first DNS label and
	// matches only a single label. You cannot have a wildcard label by itself (e.g. Host == "*").
	// Requests will be matched against the Host field in the following way:
	// 1. If Host is precise, the request matches this rule if the http host header is equal to Host.
	// 2. If Host is a wildcard, then the request matches this rule if the http host header
	// is to equal to the suffix (removing the first label) of the wildcard rule.
	// +optional
	host?: string @go(Host) @protobuf(1,bytes,opt)

	#IngressRuleValue
}

// IngressRuleValue represents a rule to apply against incoming requests. If the
// rule is satisfied, the request is routed to the specified backend. Currently
// mixing different types of rules in a single Ingress is disallowed, so exactly
// one of the following must be set.
#IngressRuleValue: {
	// +optional
	http?: null | #HTTPIngressRuleValue @go(HTTP,*HTTPIngressRuleValue) @protobuf(1,bytes,opt)
}

// HTTPIngressRuleValue is a list of http selectors pointing to backends.
// In the example: http://<host>/<path>?<searchpart> -> backend where
// where parts of the url correspond to RFC 3986, this resource will be used
// to match against everything after the last '/' and before the first '?'
// or '#'.
#HTTPIngressRuleValue: {
	// A collection of paths that map requests to backends.
	// +listType=atomic
	paths: [...#HTTPIngressPath] @go(Paths,[]HTTPIngressPath) @protobuf(1,bytes,rep)
}

// PathType represents the type of path referred to by a HTTPIngressPath.
#PathType: string // #enumPathType

#enumPathType:
	#PathTypeExact |
	#PathTypePrefix |
	#PathTypeImplementationSpecific

// PathTypeExact matches the URL path exactly and with case sensitivity.
#PathTypeExact: #PathType & "Exact"

// PathTypePrefix matches based on a URL path prefix split by '/'. Matching
// is case sensitive and done on a path element by element basis. A path
// element refers to the list of labels in the path split by the '/'
// separator. A request is a match for path p if every p is an element-wise
// prefix of p of the request path. Note that if the last element of the
// path is a substring of the last element in request path, it is not a
// match (e.g. /foo/bar matches /foo/bar/baz, but does not match
// /foo/barbaz). If multiple matching paths exist in an Ingress spec, the
// longest matching path is given priority.
// Examples:
// - /foo/bar does not match requests to /foo/barbaz
// - /foo/bar matches request to /foo/bar and /foo/bar/baz
// - /foo and /foo/ both match requests to /foo and /foo/. If both paths are
//   present in an Ingress spec, the longest matching path (/foo/) is given
//   priority.
#PathTypePrefix: #PathType & "Prefix"

// PathTypeImplementationSpecific matching is up to the IngressClass.
// Implementations can treat this as a separate PathType or treat it
// identically to Prefix or Exact path types.
#PathTypeImplementationSpecific: #PathType & "ImplementationSpecific"

// HTTPIngressPath associates a path with a backend. Incoming urls matching the
// path are forwarded to the backend.
#HTTPIngressPath: {
	// Path is matched against the path of an incoming request. Currently it can
	// contain characters disallowed from the conventional "path" part of a URL
	// as defined by RFC 3986. Paths must begin with a '/'. When unspecified,
	// all paths from incoming requests are matched.
	// +optional
	path?: string @go(Path) @protobuf(1,bytes,opt)

	// PathType determines the interpretation of the Path matching. PathType can
	// be one of the following values:
	// * Exact: Matches the URL path exactly.
	// * Prefix: Matches based on a URL path prefix split by '/'. Matching is
	//   done on a path element by element basis. A path element refers is the
	//   list of labels in the path split by the '/' separator. A request is a
	//   match for path p if every p is an element-wise prefix of p of the
	//   request path. Note that if the last element of the path is a substring
	//   of the last element in request path, it is not a match (e.g. /foo/bar
	//   matches /foo/bar/baz, but does not match /foo/barbaz).
	// * ImplementationSpecific: Interpretation of the Path matching is up to
	//   the IngressClass. Implementations can treat this as a separate PathType
	//   or treat it identically to Prefix or Exact path types.
	// Implementations are required to support all path types.
	pathType?: null | #PathType @go(PathType,*PathType) @protobuf(3,bytes,opt)

	// Backend defines the referenced service endpoint to which the traffic
	// will be forwarded to.
	backend: #IngressBackend @go(Backend) @protobuf(2,bytes,opt)
}

// IngressBackend describes all endpoints for a given service and port.
#IngressBackend: {
	// Service references a Service as a Backend.
	// This is a mutually exclusive setting with "Resource".
	// +optional
	service?: null | #IngressServiceBackend @go(Service,*IngressServiceBackend) @protobuf(4,bytes,opt)

	// Resource is an ObjectRef to another Kubernetes resource in the namespace
	// of the Ingress object. If resource is specified, a service.Name and
	// service.Port must not be specified.
	// This is a mutually exclusive setting with "Service".
	// +optional
	resource?: null | v1.#TypedLocalObjectReference @go(Resource,*v1.TypedLocalObjectReference) @protobuf(3,bytes,opt)
}

// IngressServiceBackend references a Kubernetes Service as a Backend.
#IngressServiceBackend: {
	// Name is the referenced service. The service must exist in
	// the same namespace as the Ingress object.
	name: string @go(Name) @protobuf(1,bytes,opt)

	// Port of the referenced service. A port name or port number
	// is required for a IngressServiceBackend.
	port?: #ServiceBackendPort @go(Port) @protobuf(2,bytes,opt)
}

// ServiceBackendPort is the service port being referenced.
#ServiceBackendPort: {
	// Name is the name of the port on the Service.
	// This is a mutually exclusive setting with "Number".
	// +optional
	name?: string @go(Name) @protobuf(1,bytes,opt)

	// Number is the numerical port number (e.g. 80) on the Service.
	// This is a mutually exclusive setting with "Name".
	// +optional
	number?: int32 @go(Number) @protobuf(2,bytes,opt)
}

// IngressClass represents the class of the Ingress, referenced by the Ingress
// Spec. The `ingressclass.kubernetes.io/is-default-class` annotation can be
// used to indicate that an IngressClass should be considered default. When a
// single IngressClass resource has this annotation set to true, new Ingress
// resources without a class specified will be assigned this default class.
#IngressClass: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Spec is the desired state of the IngressClass.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #IngressClassSpec @go(Spec) @protobuf(2,bytes,opt)
}

// IngressClassSpec provides information about the class of an Ingress.
#IngressClassSpec: {
	// Controller refers to the name of the controller that should handle this
	// class. This allows for different "flavors" that are controlled by the
	// same controller. For example, you may have different Parameters for the
	// same implementing controller. This should be specified as a
	// domain-prefixed path no more than 250 characters in length, e.g.
	// "acme.io/ingress-controller". This field is immutable.
	controller?: string @go(Controller) @protobuf(1,bytes,opt)

	// Parameters is a link to a custom resource containing additional
	// configuration for the controller. This is optional if the controller does
	// not require extra parameters.
	// +optional
	parameters?: null | v1.#TypedLocalObjectReference @go(Parameters,*v1.TypedLocalObjectReference) @protobuf(2,bytes,opt)
}

// IngressClassList is a collection of IngressClasses.
#IngressClassList: {
	metav1.#TypeMeta

	// Standard list metadata.
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// Items is the list of IngressClasses.
	items: [...#IngressClass] @go(Items,[]IngressClass) @protobuf(2,bytes,rep)
}
