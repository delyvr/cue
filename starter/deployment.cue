package starter

import (
    appsv1 "github.com/delyvr/cue/k8s/api/apps/v1"
    corev1 "github.com/delyvr/cue/k8s/api/core/v1"
)

#Deployment: appsv1.#Deployment
#Deployment: {
    #name: string
    #namespace: string | corev1.#NamespaceDefault

    metadata: {
        name: #name
        namespace: #namespace
    }
}