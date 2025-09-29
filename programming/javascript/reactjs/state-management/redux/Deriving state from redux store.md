#software-architecture #software-engineering #reactjs #javascript #jsx #functional-programming #high-order-function #event-driven-programming #best-practice 
# Selector function
- A selector function is a function that accepts the Redux store state (or part of the state) as an argument, and returns data that is based on that state.
```Javascript title='Selector function example'
// Arrow function, direct lookup
const selectEntities = state => state.entities

// Function declaration, mapping over an array to derive values
function selectItemIds(state) {
  return state.items.map(item => item.id)
}

// Function declaration, encapsulating a deep lookup
function selectSomeSpecificField(state) {
  return state.some.deeply.nested.field
}

// Arrow function, deriving values from an array
const selectItemsWhoseNamesStartWith = (items, namePrefix) =>
  items.filter(item => item.name.startsWith(namePrefix))
```
- Only the *reducer functions* and *selectors* should be aware of the exact state structure so that in case the location of state is changed, only these pieces of logic are changed.
```JSX title='Anti pattern for React selectors when the statusCustomized always returns a new reference and thus cannot be cached'
import { useFilters } from '@/hooks/Filter';
import { usePagination } from '@/hooks/Pagination';
import { useRetirementStatusFilterMapper } from '@/modules/retirement/mapper/retirement-status-filter-mapper';
import { useRetirementStatusTableMapper } from '@/modules/retirement/mapper/retirement-status-table-mapper';
import { getRetirementStatusPage, bulkUpdateRetirementStatusForAllStaffs } from '@/modules/retirement/redux/r-staff-retirement-status';
import { useEffect } from 'react';
import { useSelector } from 'react-redux';
import dayjs from 'dayjs';
import { RetirementStatusDataTable, DataTableHeader, TablePagination } from '@/components/_component';


const RetirementStatusAdminPage = () => {
    const { pageNumber, pageSize, changePagination, totalItem, pageSizeLevels } = usePagination('RetirementStatus.status');
    const { filters, updateFilters, isFiltering, setFiltering } = useFilters([]);

    const loading = useSelector(state => state?.RetirementStatus?.status?.loading ?? false);
    const status = useSelector(state => state?.RetirementStatus?.status?.items?.list ?? []);
    // Anti pattern because the statusCustomized does not take use of memoization
    const statusCustomized = status.map((s) => ({
        ...s,
        eligibleMoment: dayjs().month(s.eligibleRetirementMoment.month).year(s.eligibleRetirementMoment.year).format('MM-YYYY'),
        actualMoment: (s.actualRetirementMoment && s.actualRetirementMoment.month && s.actualRetirementMoment.year)
            ? dayjs().month(s.actualRetirementMoment.month).year(s.actualRetirementMoment.year).format('MM-YYYY') : 'Không'
    }));

    const filterMapper = useRetirementStatusFilterMapper();
    const tableMapper = useRetirementStatusTableMapper();

    useEffect(() => {
        if (isFiltering.current) {
            getRetirementStatusPage(pageNumber, pageSize, filters);
        } else {
            setFiltering(false);
        }
    }, [pageNumber, pageSize]);

    const filterRetirementStatus = () => {
        setFiltering(true);
        changePagination(1, pageSize);
        getRetirementStatusPage(1, pageSize, filters);
    };

    const bulkUpdateRetirementStatus = () => {
        bulkUpdateRetirementStatusForAllStaffs();
    };

    const updateRetirementStatusOfStaff = () => { };

    return <div style={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
        <DataTableHeader
            modalTitle='Tình trạng nghỉ hưu'
            filter={true}
            filters={filters}
            filterAttributeMapper={filterMapper}
            updateFilterFunction={updateFilters}
            filterFunction={filterRetirementStatus}
            isUpdate={true}
            updateFunction={bulkUpdateRetirementStatus}
            loading={loading}
        />
        <div style={{ flex: 1, overflow: 'hidden' }}>
            <RetirementStatusDataTable
                name='Tình trạng nghỉ hưu'
                dataSource={statusCustomized}
                attributeMapper={tableMapper}
                updateItemFunc={() => { }}
                deleteItemFunc={() => { }}
                pageNumber={pageNumber}
                pageSize={pageSize}
            />
        </div>
        <TablePagination
            totalItem={totalItem}
            pageNumber={pageNumber}
            pageSize={pageSize}
            onChangeFunction={changePagination}
            pageSizeOptions={pageSizeLevels}
            loading={loading}
        />
    </div>;
};

export default RetirementStatusAdminPage;
```

# Memoizing selectors
- Selectors used with `useSelector` or `mapState` will be re-run after every dispatched action, regardless of what section of the Redux root state was actually updated.
- `useSelector` and `mapState` rely on `===` (strict equality) checks of the return values to determine if the component needs to re-render. If a selector _always_ returns new references, it will force the component to re-render even if the derived data is effectively the same as last time.
- `createSelector` optimizes performance by memoizing the inputs of reducer functions and only re-run them when their inputs change.
```JSX title='Sample for createSelector callback'
const selectA = state => state.a
const selectB = state => state.b
const selectC = state => state.c

const selectABC = createSelector([selectA, selectB, selectC], (a, b, c) => {
  // do something with a, b, and c, and return a result
  return a + b + c
})

// Call the selector function and get a result
const abc = selectABC(state)

// could also be written as separate arguments, and works exactly the same
const selectABC2 = createSelector(selectA, selectB, selectC, (a, b, c) => {
  // do something with a, b, and c, and return a result
  return a + b + c
})
```

```JSX title='createSelector helps cache the result of the selector function'
import { usePagination } from '@/hooks/Pagination';
import { RetirementExtensionDataTable, RetirementExtensionDataTableHeader, TablePagination } from '@/components/_component';
import { useSelector } from 'react-redux';
import { useRetirementExtensionTableMapper } from '@/modules/retirement/mapper/retirement-extension-table-mapper';
import { useRetirementExtensionFilterMapper } from '@/modules/retirement/mapper/retirement-extension-filter-mapper';
import { useEffect } from 'react';
import { useFilters } from '@/hooks/Filter';
import { createRetirementExtensionOfStaff, deleteRetirementExtensionOfStaff, getRetirementExtensionPage, updateRetirementExtensionOfStaff } from '@/modules/retirement/redux/r-extension';
import dayjs from 'dayjs';
import { useRetirementExtensionCreateMapper } from '@/modules/retirement/mapper/retirement-extension-create-mapper';
import { createSelector } from '@reduxjs/toolkit';

const selectRetirementStatus = createSelector(
    state => state?.RetirementExtension?.status?.items?.list ?? [],
    (status) => status.map((s) => {
        const actualRetirementAge = s.actualRetirementMoment ?
            dayjs().month(s.actualRetirementMoment.month).year(s.actualRetirementMoment.year).diff(dayjs(parseInt(s.dateOfBirth)), 'month') : null;
        const expectedRetirementMoment = s.extensionMoment ? dayjs().month(s.extensionMoment.month).year(s.extensionMoment.year) :
            dayjs().month(s.eligibleRetirementMoment.month).year(s.eligibleRetirementMoment.year);
        return {
            ...s,
            eligibleRetirementMomentDisplay: dayjs().month(s.eligibleRetirementMoment.month).year(s.eligibleRetirementMoment.year).format('MM-YYYY'),
            actualRetirementMomentDisplay: (s.actualRetirementMoment && s.actualRetirementMoment.month && s.actualRetirementMoment.year)
                ? `Tháng ${dayjs().month(s.actualRetirementMoment.month).year(s.actualRetirementMoment.year).format('MM-YYYY')}` : 'Không',
            extensionRetirementMomentDisplay: s.extensionMoment ?
                `Tháng ${dayjs().month(s.extensionMoment.month).year(s.extensionMoment.year).format('MM-YYYY')}` : 'Không',
            extensionMomentUpdate: s.extensionMoment ?
                dayjs().month(s.extensionMoment.month).year(s.extensionMoment.year) : null,
            expectedRetirementMomentDisplay: expectedRetirementMoment.format('MM-YYYY'),
            actualRetirementAgeDisplay: actualRetirementAge ? `${Math.floor(actualRetirementAge / 12)} tuổi ${actualRetirementAge % 12} tháng` : 'Không',
            isRetired: !!s.actualRetirementMoment,
        };
    })
);

const RetirementExtensionAdminPage = () => {
    const { pageNumber, pageSize, changePagination, totalItem, pageSizeLevels } = usePagination('ExtensionStatus.status');
    const { filters, updateFilters, isFiltering, setFiltering } = useFilters([]);

    const loading = useSelector(state => state?.RetirementExtension?.status?.loading ?? false);
    const retirementStatus = useSelector(selectRetirementStatus);
    const tableMapper = useRetirementExtensionTableMapper();
    const filterMapper = useRetirementExtensionFilterMapper();

    const createMapper = useRetirementExtensionCreateMapper();

    const filterExtensionStatus = () => {
        setFiltering(true);
        changePagination(1, pageSize);
        getRetirementExtensionPage(1, pageSize, filters);
    };

    const handleCreateRetirementExtension = (value) => {
        createRetirementExtensionOfStaff(value.userId, value);
    };

    useEffect(() => {
        if (isFiltering) {
            getRetirementExtensionPage(pageNumber, pageSize, filters);
        } else {
            setFiltering(false);
        }
    }, [pageNumber, pageSize]);

    return <div style={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
        <RetirementExtensionDataTableHeader
            modalTitle='gia hạn'
            filter={true}
            filters={filters}
            filterAttributeMapper={filterMapper}
            createAttributeMapper={createMapper}
            updateFilterFunction={updateFilters}
            filterFunction={filterExtensionStatus}
            loading={loading}
            addFunction={handleCreateRetirementExtension}
        />
        <div style={{ flex: 1, overflow: 'hidden' }}>
            <RetirementExtensionDataTable
                name='gia hạn'
                dataSource={retirementStatus}
                attributeMapper={tableMapper}
                pageNumber={pageNumber}
                pageSize={pageSize}
                updateItemFunc={updateRetirementExtensionOfStaff}
                deleteItemFunc={deleteRetirementExtensionOfStaff}
                totalItem={totalItem}
            />
        </div>
        <TablePagination
            totalItem={totalItem}
            pageSizeLevels={pageSizeLevels}
            pageNumber={pageNumber}
            pageSize={pageSize}
            changePagination={changePagination}
            loading={loading}
            writePermission={true}
        />
    </div>;
};

export default RetirementExtensionAdminPage;
```
- `createSelector` only memoizes the most recent set of parameters.
## Nested selectors
- Nested selectors are also supported by `createSelector`
```JSX title='Nested selectors example'
const selectTodos = state => state.todos

const selectCompletedTodos = createSelector([selectTodos], todos =>
  todos.filter(todo => todo.completed)
)

const selectCompletedTodoDescriptions = createSelector(
  [selectCompletedTodos],
  completedTodos => completedTodos.map(todo => todo.text)
)
```
## Passing input parameters
- A `Reselect`-generated selector function can be called with arbitrary number of arguments as long as the selector functions are well defined.
```JSX title='Pass multiple arguments into the createSelector function'
const selectItemsByCategory = createSelector(
  [
    // Usual first input - extract value from `state`
    state => state.items,
    // Take the second arg, `category`, and forward to the output selector
    (state, category) => category
  ],
  // Output selector gets (`items, category)` as args
  (items, category) => items.filter(item => item.category === category)
)

// Usage
const electronicItems = selectItemsByCategory(state, "electronics");
```
## Selector factory
- `createSelector` only has a default cache size of 1,  and this is *per each unique instance* of a selector.
---
# References
1. https://redux.js.org/usage/deriving-data-selectors
2. https://github.com/reduxjs/reselect for `reselect` library in React Redux.
3. https://github.com/toomuchdesign/re-reselect for Alternative libraries.
4. 