// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/flowcontrol/v1beta1

package v1beta1

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

#APIGroupAll:    "*"
#ResourceAll:    "*"
#VerbAll:        "*"
#NonResourceAll: "*"
#NameAll:        "*"
#NamespaceEvery: "*"

#PriorityLevelConfigurationNameExempt:   "exempt"
#PriorityLevelConfigurationNameCatchAll: "catch-all"
#FlowSchemaNameExempt:                   "exempt"
#FlowSchemaNameCatchAll:                 "catch-all"

#FlowSchemaConditionDangling:                          "Dangling"
#PriorityLevelConfigurationConditionConcurrencyShared: "ConcurrencyShared"

#FlowSchemaMaxMatchingPrecedence: int32 & 10000

#ResponseHeaderMatchedPriorityLevelConfigurationUID: "X-Kubernetes-PF-PriorityLevel-UID"
#ResponseHeaderMatchedFlowSchemaUID:                 "X-Kubernetes-PF-FlowSchema-UID"

// FlowSchema defines the schema of a group of flows. Note that a flow is made up of a set of inbound API requests with
// similar attributes and is identified by a pair of strings: the name of the FlowSchema and a "flow distinguisher".
#FlowSchema: {
	metav1.#TypeMeta

	// `metadata` is the standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// `spec` is the specification of the desired behavior of a FlowSchema.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #FlowSchemaSpec @go(Spec) @protobuf(2,bytes,opt)

	// `status` is the current status of a FlowSchema.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	status?: #FlowSchemaStatus @go(Status) @protobuf(3,bytes,opt)
}

// FlowSchemaList is a list of FlowSchema objects.
#FlowSchemaList: {
	metav1.#TypeMeta

	// `metadata` is the standard list metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// `items` is a list of FlowSchemas.
	items: [...#FlowSchema] @go(Items,[]FlowSchema) @protobuf(2,bytes,rep)
}

// FlowSchemaSpec describes how the FlowSchema's specification looks like.
#FlowSchemaSpec: {
	// `priorityLevelConfiguration` should reference a PriorityLevelConfiguration in the cluster. If the reference cannot
	// be resolved, the FlowSchema will be ignored and marked as invalid in its status.
	// Required.
	priorityLevelConfiguration: #PriorityLevelConfigurationReference @go(PriorityLevelConfiguration) @protobuf(1,bytes,opt)

	// `matchingPrecedence` is used to choose among the FlowSchemas that match a given request. The chosen
	// FlowSchema is among those with the numerically lowest (which we take to be logically highest)
	// MatchingPrecedence.  Each MatchingPrecedence value must be ranged in [1,10000].
	// Note that if the precedence is not specified, it will be set to 1000 as default.
	// +optional
	matchingPrecedence: int32 @go(MatchingPrecedence) @protobuf(2,varint,opt)

	// `distinguisherMethod` defines how to compute the flow distinguisher for requests that match this schema.
	// `nil` specifies that the distinguisher is disabled and thus will always be the empty string.
	// +optional
	distinguisherMethod?: null | #FlowDistinguisherMethod @go(DistinguisherMethod,*FlowDistinguisherMethod) @protobuf(3,bytes,opt)

	// `rules` describes which requests will match this flow schema. This FlowSchema matches a request if and only if
	// at least one member of rules matches the request.
	// if it is an empty slice, there will be no requests matching the FlowSchema.
	// +listType=atomic
	// +optional
	rules?: [...#PolicyRulesWithSubjects] @go(Rules,[]PolicyRulesWithSubjects) @protobuf(4,bytes,rep)
}

// FlowDistinguisherMethodType is the type of flow distinguisher method
#FlowDistinguisherMethodType: string // #enumFlowDistinguisherMethodType

#enumFlowDistinguisherMethodType:
	#FlowDistinguisherMethodByUserType |
	#FlowDistinguisherMethodByNamespaceType

// FlowDistinguisherMethodByUserType specifies that the flow distinguisher is the username in the request.
// This type is used to provide some insulation between users.
#FlowDistinguisherMethodByUserType: #FlowDistinguisherMethodType & "ByUser"

// FlowDistinguisherMethodByNamespaceType specifies that the flow distinguisher is the namespace of the
// object that the request acts upon. If the object is not namespaced, or if the request is a non-resource
// request, then the distinguisher will be the empty string. An example usage of this type is to provide
// some insulation between tenants in a situation where there are multiple tenants and each namespace
// is dedicated to a tenant.
#FlowDistinguisherMethodByNamespaceType: #FlowDistinguisherMethodType & "ByNamespace"

// FlowDistinguisherMethod specifies the method of a flow distinguisher.
#FlowDistinguisherMethod: {
	// `type` is the type of flow distinguisher method
	// The supported types are "ByUser" and "ByNamespace".
	// Required.
	type: #FlowDistinguisherMethodType @go(Type) @protobuf(1,bytes,opt)
}

// PriorityLevelConfigurationReference contains information that points to the "request-priority" being used.
#PriorityLevelConfigurationReference: {
	// `name` is the name of the priority level configuration being referenced
	// Required.
	name: string @go(Name) @protobuf(1,bytes,opt)
}

// PolicyRulesWithSubjects prescribes a test that applies to a request to an apiserver. The test considers the subject
// making the request, the verb being requested, and the resource to be acted upon. This PolicyRulesWithSubjects matches
// a request if and only if both (a) at least one member of subjects matches the request and (b) at least one member
// of resourceRules or nonResourceRules matches the request.
#PolicyRulesWithSubjects: {
	// subjects is the list of normal user, serviceaccount, or group that this rule cares about.
	// There must be at least one member in this slice.
	// A slice that includes both the system:authenticated and system:unauthenticated user groups matches every request.
	// +listType=atomic
	// Required.
	subjects: [...#Subject] @go(Subjects,[]Subject) @protobuf(1,bytes,rep)

	// `resourceRules` is a slice of ResourcePolicyRules that identify matching requests according to their verb and the
	// target resource.
	// At least one of `resourceRules` and `nonResourceRules` has to be non-empty.
	// +listType=atomic
	// +optional
	resourceRules?: [...#ResourcePolicyRule] @go(ResourceRules,[]ResourcePolicyRule) @protobuf(2,bytes,opt)

	// `nonResourceRules` is a list of NonResourcePolicyRules that identify matching requests according to their verb
	// and the target non-resource URL.
	// +listType=atomic
	// +optional
	nonResourceRules?: [...#NonResourcePolicyRule] @go(NonResourceRules,[]NonResourcePolicyRule) @protobuf(3,bytes,opt)
}

// Subject matches the originator of a request, as identified by the request authentication system. There are three
// ways of matching an originator; by user, group, or service account.
// +union
#Subject: {
	// Required
	// +unionDiscriminator
	kind: #SubjectKind @go(Kind) @protobuf(1,bytes,opt)

	// +optional
	user?: null | #UserSubject @go(User,*UserSubject) @protobuf(2,bytes,opt)

	// +optional
	group?: null | #GroupSubject @go(Group,*GroupSubject) @protobuf(3,bytes,opt)

	// +optional
	serviceAccount?: null | #ServiceAccountSubject @go(ServiceAccount,*ServiceAccountSubject) @protobuf(4,bytes,opt)
}

// SubjectKind is the kind of subject.
#SubjectKind: string // #enumSubjectKind

#enumSubjectKind:
	#SubjectKindUser |
	#SubjectKindGroup |
	#SubjectKindServiceAccount

#SubjectKindUser:           #SubjectKind & "User"
#SubjectKindGroup:          #SubjectKind & "Group"
#SubjectKindServiceAccount: #SubjectKind & "ServiceAccount"

// UserSubject holds detailed information for user-kind subject.
#UserSubject: {
	// `name` is the username that matches, or "*" to match all usernames.
	// Required.
	name: string @go(Name) @protobuf(1,bytes,opt)
}

// GroupSubject holds detailed information for group-kind subject.
#GroupSubject: {
	// name is the user group that matches, or "*" to match all user groups.
	// See https://github.com/kubernetes/apiserver/blob/master/pkg/authentication/user/user.go for some
	// well-known group names.
	// Required.
	name: string @go(Name) @protobuf(1,bytes,opt)
}

// ServiceAccountSubject holds detailed information for service-account-kind subject.
#ServiceAccountSubject: {
	// `namespace` is the namespace of matching ServiceAccount objects.
	// Required.
	namespace: string @go(Namespace) @protobuf(1,bytes,opt)

	// `name` is the name of matching ServiceAccount objects, or "*" to match regardless of name.
	// Required.
	name: string @go(Name) @protobuf(2,bytes,opt)
}

// ResourcePolicyRule is a predicate that matches some resource
// requests, testing the request's verb and the target resource. A
// ResourcePolicyRule matches a resource request if and only if: (a)
// at least one member of verbs matches the request, (b) at least one
// member of apiGroups matches the request, (c) at least one member of
// resources matches the request, and (d) least one member of
// namespaces matches the request.
#ResourcePolicyRule: {
	// `verbs` is a list of matching verbs and may not be empty.
	// "*" matches all verbs and, if present, must be the only entry.
	// +listType=set
	// Required.
	verbs: [...string] @go(Verbs,[]string) @protobuf(1,bytes,rep)

	// `apiGroups` is a list of matching API groups and may not be empty.
	// "*" matches all API groups and, if present, must be the only entry.
	// +listType=set
	// Required.
	apiGroups: [...string] @go(APIGroups,[]string) @protobuf(2,bytes,rep)

	// `resources` is a list of matching resources (i.e., lowercase
	// and plural) with, if desired, subresource.  For example, [
	// "services", "nodes/status" ].  This list may not be empty.
	// "*" matches all resources and, if present, must be the only entry.
	// Required.
	// +listType=set
	resources: [...string] @go(Resources,[]string) @protobuf(3,bytes,rep)

	// `clusterScope` indicates whether to match requests that do not
	// specify a namespace (which happens either because the resource
	// is not namespaced or the request targets all namespaces).
	// If this field is omitted or false then the `namespaces` field
	// must contain a non-empty list.
	// +optional
	clusterScope?: bool @go(ClusterScope) @protobuf(4,varint,opt)

	// `namespaces` is a list of target namespaces that restricts
	// matches.  A request that specifies a target namespace matches
	// only if either (a) this list contains that target namespace or
	// (b) this list contains "*".  Note that "*" matches any
	// specified namespace but does not match a request that _does
	// not specify_ a namespace (see the `clusterScope` field for
	// that).
	// This list may be empty, but only if `clusterScope` is true.
	// +optional
	// +listType=set
	namespaces: [...string] @go(Namespaces,[]string) @protobuf(5,bytes,rep)
}

// NonResourcePolicyRule is a predicate that matches non-resource requests according to their verb and the
// target non-resource URL. A NonResourcePolicyRule matches a request if and only if both (a) at least one member
// of verbs matches the request and (b) at least one member of nonResourceURLs matches the request.
#NonResourcePolicyRule: {
	// `verbs` is a list of matching verbs and may not be empty.
	// "*" matches all verbs. If it is present, it must be the only entry.
	// +listType=set
	// Required.
	verbs: [...string] @go(Verbs,[]string) @protobuf(1,bytes,rep)

	// `nonResourceURLs` is a set of url prefixes that a user should have access to and may not be empty.
	// For example:
	//   - "/healthz" is legal
	//   - "/hea*" is illegal
	//   - "/hea" is legal but matches nothing
	//   - "/hea/*" also matches nothing
	//   - "/healthz/*" matches all per-component health checks.
	// "*" matches all non-resource urls. if it is present, it must be the only entry.
	// +listType=set
	// Required.
	nonResourceURLs: [...string] @go(NonResourceURLs,[]string) @protobuf(6,bytes,rep)
}

// FlowSchemaStatus represents the current state of a FlowSchema.
#FlowSchemaStatus: {
	// `conditions` is a list of the current states of FlowSchema.
	// +listType=map
	// +listMapKey=type
	// +optional
	conditions?: [...#FlowSchemaCondition] @go(Conditions,[]FlowSchemaCondition) @protobuf(1,bytes,rep)
}

// FlowSchemaCondition describes conditions for a FlowSchema.
#FlowSchemaCondition: {
	// `type` is the type of the condition.
	// Required.
	type?: #FlowSchemaConditionType @go(Type) @protobuf(1,bytes,opt)

	// `status` is the status of the condition.
	// Can be True, False, Unknown.
	// Required.
	status?: #ConditionStatus @go(Status) @protobuf(2,bytes,opt)

	// `lastTransitionTime` is the last time the condition transitioned from one status to another.
	lastTransitionTime?: metav1.#Time @go(LastTransitionTime) @protobuf(3,bytes,opt)

	// `reason` is a unique, one-word, CamelCase reason for the condition's last transition.
	reason?: string @go(Reason) @protobuf(4,bytes,opt)

	// `message` is a human-readable message indicating details about last transition.
	message?: string @go(Message) @protobuf(5,bytes,opt)
}

// FlowSchemaConditionType is a valid value for FlowSchemaStatusCondition.Type
#FlowSchemaConditionType: string

// PriorityLevelConfiguration represents the configuration of a priority level.
#PriorityLevelConfiguration: {
	metav1.#TypeMeta

	// `metadata` is the standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// `spec` is the specification of the desired behavior of a "request-priority".
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #PriorityLevelConfigurationSpec @go(Spec) @protobuf(2,bytes,opt)

	// `status` is the current status of a "request-priority".
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	status?: #PriorityLevelConfigurationStatus @go(Status) @protobuf(3,bytes,opt)
}

// PriorityLevelConfigurationList is a list of PriorityLevelConfiguration objects.
#PriorityLevelConfigurationList: {
	metav1.#TypeMeta

	// `metadata` is the standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// `items` is a list of request-priorities.
	items: [...#PriorityLevelConfiguration] @go(Items,[]PriorityLevelConfiguration) @protobuf(2,bytes,rep)
}

// PriorityLevelConfigurationSpec specifies the configuration of a priority level.
// +union
#PriorityLevelConfigurationSpec: {
	// `type` indicates whether this priority level is subject to
	// limitation on request execution.  A value of `"Exempt"` means
	// that requests of this priority level are not subject to a limit
	// (and thus are never queued) and do not detract from the
	// capacity made available to other priority levels.  A value of
	// `"Limited"` means that (a) requests of this priority level
	// _are_ subject to limits and (b) some of the server's limited
	// capacity is made available exclusively to this priority level.
	// Required.
	// +unionDiscriminator
	type: #PriorityLevelEnablement @go(Type) @protobuf(1,bytes,opt)

	// `limited` specifies how requests are handled for a Limited priority level.
	// This field must be non-empty if and only if `type` is `"Limited"`.
	// +optional
	limited?: null | #LimitedPriorityLevelConfiguration @go(Limited,*LimitedPriorityLevelConfiguration) @protobuf(2,bytes,opt)
}

// PriorityLevelEnablement indicates whether limits on execution are enabled for the priority level
#PriorityLevelEnablement: string // #enumPriorityLevelEnablement

#enumPriorityLevelEnablement:
	#PriorityLevelEnablementExempt |
	#PriorityLevelEnablementLimited

// PriorityLevelEnablementExempt means that requests are not subject to limits
#PriorityLevelEnablementExempt: #PriorityLevelEnablement & "Exempt"

// PriorityLevelEnablementLimited means that requests are subject to limits
#PriorityLevelEnablementLimited: #PriorityLevelEnablement & "Limited"

// LimitedPriorityLevelConfiguration specifies how to handle requests that are subject to limits.
// It addresses two issues:
//  * How are requests for this priority level limited?
//  * What should be done with requests that exceed the limit?
#LimitedPriorityLevelConfiguration: {
	// `assuredConcurrencyShares` (ACS) configures the execution
	// limit, which is a limit on the number of requests of this
	// priority level that may be exeucting at a given time.  ACS must
	// be a positive number. The server's concurrency limit (SCL) is
	// divided among the concurrency-controlled priority levels in
	// proportion to their assured concurrency shares. This produces
	// the assured concurrency value (ACV) --- the number of requests
	// that may be executing at a time --- for each such priority
	// level:
	//
	//             ACV(l) = ceil( SCL * ACS(l) / ( sum[priority levels k] ACS(k) ) )
	//
	// bigger numbers of ACS mean more reserved concurrent requests (at the
	// expense of every other PL).
	// This field has a default value of 30.
	// +optional
	assuredConcurrencyShares: int32 @go(AssuredConcurrencyShares) @protobuf(1,varint,opt)

	// `limitResponse` indicates what to do with requests that can not be executed right now
	limitResponse?: #LimitResponse @go(LimitResponse) @protobuf(2,bytes,opt)
}

// LimitResponse defines how to handle requests that can not be executed right now.
// +union
#LimitResponse: {
	// `type` is "Queue" or "Reject".
	// "Queue" means that requests that can not be executed upon arrival
	// are held in a queue until they can be executed or a queuing limit
	// is reached.
	// "Reject" means that requests that can not be executed upon arrival
	// are rejected.
	// Required.
	// +unionDiscriminator
	type: #LimitResponseType @go(Type) @protobuf(1,bytes,opt)

	// `queuing` holds the configuration parameters for queuing.
	// This field may be non-empty only if `type` is `"Queue"`.
	// +optional
	queuing?: null | #QueuingConfiguration @go(Queuing,*QueuingConfiguration) @protobuf(2,bytes,opt)
}

// LimitResponseType identifies how a Limited priority level handles a request that can not be executed right now
#LimitResponseType: string // #enumLimitResponseType

#enumLimitResponseType:
	#LimitResponseTypeQueue |
	#LimitResponseTypeReject

// LimitResponseTypeQueue means that requests that can not be executed right now are queued until they can be executed or a queuing limit is hit
#LimitResponseTypeQueue: #LimitResponseType & "Queue"

// LimitResponseTypeReject means that requests that can not be executed right now are rejected
#LimitResponseTypeReject: #LimitResponseType & "Reject"

// QueuingConfiguration holds the configuration parameters for queuing
#QueuingConfiguration: {
	// `queues` is the number of queues for this priority level. The
	// queues exist independently at each apiserver. The value must be
	// positive.  Setting it to 1 effectively precludes
	// shufflesharding and thus makes the distinguisher method of
	// associated flow schemas irrelevant.  This field has a default
	// value of 64.
	// +optional
	queues: int32 @go(Queues) @protobuf(1,varint,opt)

	// `handSize` is a small positive number that configures the
	// shuffle sharding of requests into queues.  When enqueuing a request
	// at this priority level the request's flow identifier (a string
	// pair) is hashed and the hash value is used to shuffle the list
	// of queues and deal a hand of the size specified here.  The
	// request is put into one of the shortest queues in that hand.
	// `handSize` must be no larger than `queues`, and should be
	// significantly smaller (so that a few heavy flows do not
	// saturate most of the queues).  See the user-facing
	// documentation for more extensive guidance on setting this
	// field.  This field has a default value of 8.
	// +optional
	handSize: int32 @go(HandSize) @protobuf(2,varint,opt)

	// `queueLengthLimit` is the maximum number of requests allowed to
	// be waiting in a given queue of this priority level at a time;
	// excess requests are rejected.  This value must be positive.  If
	// not specified, it will be defaulted to 50.
	// +optional
	queueLengthLimit: int32 @go(QueueLengthLimit) @protobuf(3,varint,opt)
}

// PriorityLevelConfigurationConditionType is a valid value for PriorityLevelConfigurationStatusCondition.Type
#PriorityLevelConfigurationConditionType: string

// PriorityLevelConfigurationStatus represents the current state of a "request-priority".
#PriorityLevelConfigurationStatus: {
	// `conditions` is the current state of "request-priority".
	// +listType=map
	// +listMapKey=type
	// +optional
	conditions?: [...#PriorityLevelConfigurationCondition] @go(Conditions,[]PriorityLevelConfigurationCondition) @protobuf(1,bytes,rep)
}

// PriorityLevelConfigurationCondition defines the condition of priority level.
#PriorityLevelConfigurationCondition: {
	// `type` is the type of the condition.
	// Required.
	type?: #PriorityLevelConfigurationConditionType @go(Type) @protobuf(1,bytes,opt)

	// `status` is the status of the condition.
	// Can be True, False, Unknown.
	// Required.
	status?: #ConditionStatus @go(Status) @protobuf(2,bytes,opt)

	// `lastTransitionTime` is the last time the condition transitioned from one status to another.
	lastTransitionTime?: metav1.#Time @go(LastTransitionTime) @protobuf(3,bytes,opt)

	// `reason` is a unique, one-word, CamelCase reason for the condition's last transition.
	reason?: string @go(Reason) @protobuf(4,bytes,opt)

	// `message` is a human-readable message indicating details about last transition.
	message?: string @go(Message) @protobuf(5,bytes,opt)
}

// ConditionStatus is the status of the condition.
#ConditionStatus: string // #enumConditionStatus

#enumConditionStatus:
	#ConditionTrue |
	#ConditionFalse |
	#ConditionUnknown

#ConditionTrue:    #ConditionStatus & "True"
#ConditionFalse:   #ConditionStatus & "False"
#ConditionUnknown: #ConditionStatus & "Unknown"
