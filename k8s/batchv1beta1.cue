
// Code generated by generate.go. DO NOT EDIT.
package k8s

import (
	kube "github.com/delyvr/cue/k8s/gen/k8s.io/api/batch/v1beta1"
)


batch: v1beta1:  #JobTemplate: kube.#JobTemplate
batch: v1beta1:  #JobTemplate: {
	Kind: "JobTemplate"
	apiVersion: "batch/v1beta1"
}

batch: v1beta1:  #CronJob: kube.#CronJob
batch: v1beta1:  #CronJob: {
	Kind: "CronJob"
	apiVersion: "batch/v1beta1"
}