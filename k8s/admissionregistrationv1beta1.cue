
// Code generated by generate.go. DO NOT EDIT.
package k8s

import (
	kube "github.com/delyvr/cue/k8s/gen/k8s.io/api/admissionregistration/v1beta1"
)


admissionregistration: v1beta1:  kube.#ValidatingWebhookConfiguration: {
	Kind: "ValidatingWebhookConfiguration"
	apiVersion: "admissionregistration/v1beta1"
}

admissionregistration: v1beta1:  kube.#MutatingWebhookConfiguration: {
	Kind: "MutatingWebhookConfiguration"
	apiVersion: "admissionregistration/v1beta1"
}
