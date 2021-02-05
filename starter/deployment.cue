package starter

import (
    "github.com/delyvr/cue/k8s:apps"
    "github.com/delyvr/cue/k8s:core"
)

#Deployment: apps.v1.#Deployment
#Deployment: {
    #name: string
    #namespace: string | core.v1.#NamespaceDefault
    #labels: {[string]: string} | null
    #replicas: int | *1
    #image: string
    #port: int | *80

    metadata: {
        name: #name
        namespace: #namespace
        labels: #labels
    }
    spec: {
        replicas: #replicas
        labelSelector: {
            matchLabels: {
                "app": #name
            }
        }
        template: {
            metadata: {
                labels: #labels & {
                    "app": #name
                }
            }
            spec: {
                containers: [
                    {
                        name: "app"
                        image: #image
                        ports: [
                            {
                                containerPort: #port
                            }
                        ]
                    }
                ]
            }
        }
    }
}