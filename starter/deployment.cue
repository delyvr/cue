package starter

import (
    appsv1 "github.com/delyvr/cue/k8s/api/apps/v1"
)

#Deployment: appsv1.#Deployment
#Deployment: {
    #name: string
    metadata: {
        name: #name
    }
}