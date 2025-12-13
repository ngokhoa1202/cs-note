```
design-patterns-study/
│
├── tier-1-gof-patterns/
│   ├── creational/
│   │   ├── singleton/
│   │   ├── factory-method/
│   │   ├── abstract-factory/
│   │   ├── builder/
│   │   └── prototype/
│   │
│   ├── structural/
│   │   ├── adapter/
│   │   ├── bridge/
│   │   ├── composite/
│   │   ├── decorator/
│   │   ├── facade/
│   │   ├── flyweight/
│   │   └── proxy/
│   │
│   └── behavioral/
│       ├── chain-of-responsibility/
│       ├── command/
│       ├── interpreter/
│       ├── iterator/
│       ├── mediator/
│       ├── memento/
│       ├── observer/
│       ├── state/
│       ├── strategy/
│       ├── template-method/
│       └── visitor/
│
├── tier-2-enterprise-patterns/
│   ├── data-access/
│   │   ├── data-access-object/
│   │   ├── repository/
│   │   ├── data-mapper/
│   │   ├── identity-map/
│   │   ├── lazy-loading/
│   │   ├── unit-of-work/
│   │   └── metadata-mapping/
│   │
│   ├── domain-logic/
│   │   ├── domain-model/
│   │   ├── transaction-script/
│   │   ├── service-layer/
│   │   ├── table-module/
│   │   └── specification/
│   │
│   ├── distribution/
│   │   ├── gateway/
│   │   ├── anti-corruption-layer/
│   │   ├── data-transfer-object/
│   │   └── ambassador/
│   │
│   └── concurrency/
│       ├── optimistic-offline-lock/
│       ├── version-number/
│       ├── server-session/
│       └── client-session/
│
├── tier-3-microservices-distributed/
│   ├── microservices/
│   │   ├── api-gateway/
│   │   ├── aggregator/
│   │   ├── distributed-tracing/
│   │   ├── log-aggregation/
│   │   ├── idempotent-consumer/
│   │   └── client-side-ui-composition/
│   │
│   ├── resilience/
│   │   ├── circuit-breaker/
│   │   ├── retry/
│   │   ├── backpressure/
│   │   ├── throttling/
│   │   └── health-check/
│   │
│   ├── event-driven/
│   │   ├── event-sourcing/
│   │   ├── event-driven-architecture/
│   │   ├── event-queue/
│   │   ├── event-aggregator/
│   │   ├── publish-subscribe/
│   │   ├── cqrs/
│   │   └── saga/
│   │
│   └── async/
│       ├── async-method-invocation/
│       ├── promise/
│       ├── reactor/
│       ├── producer-consumer/
│       └── queue-based-load-leveling/
│
├── tier-4-architectural-patterns/
│   ├── architectural-styles/
│   │   ├── layered-architecture/
│   │   ├── hexagonal-architecture/
│   │   ├── clean-architecture/
│   │   ├── model-view-controller/
│   │   ├── model-view-presenter/
│   │   ├── model-view-viewmodel/
│   │   ├── model-view-intent/
│   │   └── monolithic-architecture/
│   │
│   └── integration/
│       ├── service-locator/
│       ├── business-delegate/
│       ├── front-controller/
│       ├── intercepting-filter/
│       └── dependency-injection/
│
├── tier-5-concurrency-performance/
│   ├── concurrency-control/
│   │   ├── monitor/
│   │   ├── balking/
│   │   ├── double-checked-locking/
│   │   ├── guarded-suspension/
│   │   ├── active-object/
│   │   ├── half-sync-half-async/
│   │   ├── leader-followers/
│   │   ├── thread-pool-executor/
│   │   └── lockable-object/
│   │
│   ├── performance/
│   │   ├── caching/
│   │   ├── object-pool/
│   │   ├── data-locality/
│   │   ├── dirty-flag/
│   │   ├── double-buffer/
│   │   └── spatial-partition/
│   │
│   └── resource-management/
│       ├── raii/
│       └── execute-around/
│
├── tier-6-functional-modern/
│   ├── functional/
│   │   ├── monad/
│   │   ├── combinator/
│   │   ├── currying/
│   │   ├── function-composition/
│   │   ├── collection-pipeline/
│   │   └── fluent-interface/
│   │
│   └── modern/
│       ├── flux/
│       └── bloc/
│
├── tier-7-testing-quality/
│   └── testing/
│       ├── arrange-act-assert/
│       ├── object-mother/
│       ├── page-object/
│       ├── service-stub/
│       └── mute-idiom/
│
└── tier-8-specialized-advanced/
    ├── game-development/
    │   ├── game-loop/
    │   ├── bytecode/
    │   ├── component/
    │   ├── subclass-sandbox/
    │   ├── type-object/
    │   └── update-method/
    │
    ├── advanced-oo/
    │   ├── acyclic-visitor/
    │   ├── double-dispatch/
    │   ├── extension-objects/
    │   ├── naked-objects/
    │   ├── role-object/
    │   ├── separated-interface/
    │   └── twin/
    │
    ├── data-structures/
    │   ├── composite-entity/
    │   ├── abstract-document/
    │   ├── property/
    │   └── marker-interface/
    │
    ├── specialized-enterprise/
    │   ├── composite-view/
    │   ├── context-object/
    │   ├── converter/
    │   ├── notification/
    │   ├── parameter-object/
    │   ├── presentation-model/
    │   ├── private-class-data/
    │   ├── session-facade/
    │   ├── step-builder/
    │   ├── table-inheritance/
    │   ├── single-table-inheritance/
    │   ├── template-view/
    │   ├── tolerant-reader/
    │   ├── value-object/
    │   ├── page-controller/
    │   ├── serialized-entity/
    │   └── serialized-lob/
    │
    ├── cloud-devops/
    │   ├── feature-toggle/
    │   ├── leader-election/
    │   ├── map-reduce/
    │   ├── sharding/
    │   └── strangler/
    │
    ├── niche/
    │   ├── callback/
    │   ├── collecting-parameter/
    │   ├── filterer/
    │   ├── monostate/
    │   ├── multiton/
    │   ├── null-object/
    │   ├── partial-response/
    │   ├── poison-pill/
    │   ├── registry/
    │   ├── service-to-worker/
    │   ├── special-case/
    │   ├── trampoline/
    │   ├── virtual-proxy/
    │   ├── factory/
    │   ├── factory-kit/
    │   ├── data-bus/
    │   ├── delegation/
    │   ├── dynamic-proxy/
    │   ├── event-based-asynchronous/
    │   ├── fanout-fanin/
    │   ├── servant/
    │   ├── money/
    │   ├── pipeline/
    │   └── curiously-recurring-template-pattern/
    │
    └── emerging/
        ├── actor-model/
        ├── master-worker/
        └── commander/
```