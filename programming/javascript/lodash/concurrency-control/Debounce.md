#concurrency-control #lazy-loading #functional-programming #high-order-function #javascript #vanilla-javascript #event-driven-programming #lodash #typescript 

# Behavior
- `{javascript} _.debounce()` creates a debounced function that delays invoking `func` until after `wait` milliseconds have elapsed since the last time the debounced function was invoked. The debounced function comes with a `cancel` method to cancel delayed `func` invocations and a `flush` method to immediately invoke them. 
- The parameter `options`  indicates whether `func` should be invoked on the leading and/or trailing edge of the `wait` timeout. The `func` is invoked with the last arguments provided to the debounced function. Subsequent calls to the debounced function return the result of the last `func` invocation.
- The `debounce` function creates a scheduler around the original function that:
	- **Waits** for a specified delay after each call
	- **Resets the timer** if called again during the wait period
	- **Only executes** the original function after the full delay passes without interruption
# Usage
##  Asynchronously fetching API in a limited manner

```Javascript title='Debounce to limit API calls'
import { debounce } from 'lodash';

// Without debounce - BAD! Makes too many API calls
const searchInput = document.getElementById('search');
searchInput.addEventListener('input', async (e) => {
    const results = await searchAPI(e.target.value);
    displayResults(results);
});
// If user types "react", this fires 5 times: "r", "re", "rea", "reac", "react"

// With debounce - GOOD! Waits for user to stop typing
const searchAPI = async (query) => {
    const response = await fetch(`/api/search?q=${query}`);
    return response.json();
};

const debouncedSearch = debounce(async (query) => {
    const results = await searchAPI(query);
    displayResults(results);
}, 300); // Wait 300ms after user stops typing

searchInput.addEventListener('input', (e) => {
    debouncedSearch(e.target.value);
});
```

```JSX title='Lazily asynchronous select in React, combined with AntDesign'

import { PAGE_SIZE_LEVELS } from '@/constants';
import T from '@/utils/common';
import { Select, Spin } from 'antd';
import { debounce } from 'lodash';
import { useCallback, useEffect, useRef, useState } from 'react';
import { useSelector } from 'react-redux';

/**
 * @param {Object} props
 * @param {Object} props.style - Styles to apply to the component
 * @param {String} props.prefixUrl - URL to fetch options from
 * @param {Array<Object>} [props.queries]
 * @param {string} [props.queries[].key] - Query parameter key to append to the URL
 * @param {string} [props.queries[].value] - Query parameter value to append to the URL
 * @param {string} [props.attributeReturnedWillBeMapped] - Name of the label to display in the select options. Must exist in the response item
 * @param {Function} [props.mapFunction] - Function to map the fetched data to the options format 
 * @param {Function} [props.mapAttributeFunction] - Function to map the attribute returned from the API to the option value
 * @param {Function} [props.mapLabelFunction] - Function to map the attribute returned from the API to the option label
 * @param {Object} [props.reducer] - Object containing name and predicate for the reducer
 * @param {string} [props.reducer.name] - Name of the reducer to use to dispatch for re-rendering
 * @param {string} [props.reducer.path] - Path to the item in the Redux state
 * @param {(item: Object, value: Object) => boolean} [props.reducer.predicate] - Predicate to filter the options
 * @param {string} [props.reducer.error] - Error message to display if the request fails
 * @param {boolean} [props.disabled] - Whether the select is disabled
 * @param {any} [props.initialValue] - The value received to synchronize with the external form state without being reset to null
 * 
 * There must be one pair of key and value whose key is not null and value is null, so that that not attribute will be entered by the users
 * Either attributeReturnedWillBeMapped or both of mapAttributeFunction and mapLabelFunction must be passed, but not both
 */
export default function AsyncSelect({ style, prefixUrl, queries = [], attributeReturnedWillBeMapped, mapAttributeFunction = null, mapLabelFunction = null, reducer = { name: null, predicate: null, error: null }, disabled = false, initialValue }) {

    const [searchValue, setSearchValue] = useState(null);
    const [loading, setLoading] = useState(false);
    const [page, setPage] = useState(1);
    const [hasMoreOptions, setHasMoreOptions] = useState(true);
    const abortControllerRef = useRef(null);
    const [selectedValue, setSelectedValue] = useState(initialValue);

    const [error, setError] = useState(null);
    const [options, setOptions] = useState([]);
    const PAGE_SIZE = PAGE_SIZE_LEVELS[1];
    const TIMEOUT = 1000;
    const fetchAndLoadData = async (value, pageNumber = 1, append = false) => {
        try {
            if (abortControllerRef.current) { // abnormally stop the previous request
                abortControllerRef.current.abort();
            }
            abortControllerRef.current = new AbortController();
            /* Everything is fine, perform search */
            setLoading(true);
            setError(null);

            const queryString = queries.map(q => (q.value || value) ? `${encodeURIComponent(q.key)}=${encodeURIComponent(q.value ?? value)}` : '').join('&');
            const url = `${prefixUrl}/page/${pageNumber}/${PAGE_SIZE}/?${queryString}`;
            const res = await T.async.get(url);
            // all response returned is in the form of { items: {list: [...]}, pageTotal: number, totalItem: number}
            if (append) {
                setOptions((prev) => [...prev, ...res.items.list].map((item) => ({
                    value: mapAttributeFunction ? mapAttributeFunction(item) : item[attributeReturnedWillBeMapped],
                    label: mapLabelFunction ? mapLabelFunction(item) : item[attributeReturnedWillBeMapped],
                })));
            } else {
                setOptions(res.items.list.map((item) => ({
                    value: mapAttributeFunction ? mapAttributeFunction(item) : item[attributeReturnedWillBeMapped],
                    label: mapLabelFunction ? mapLabelFunction(item) : item[attributeReturnedWillBeMapped],
                    originalItem: item
                })));
            }
            setHasMoreOptions(res.items.pageTotal > pageNumber);
            setPage(pageNumber);
        } catch (error) {
            if (error.name !== 'AbortError') {
                setError('Failed to load data');
                console.error('Error loading data:', error);
                T.error(reducer.error, error, error.response.data.error.message);
            }
        } finally {
            setLoading(false);
        }
    };

    const debouncedSearch = useCallback(debounce((value) => {
        setPage(1);
        setHasMoreOptions(true);
        fetchAndLoadData(value, 1, false);
    }, TIMEOUT), []);

    const handleSearch = (value) => {
        setSearchValue(value);
        setLoading(true);
        debouncedSearch(value);
    };

    /**
     * 
     * @param {Event} e 
     */
    const handlePopupScroll = (e) => {
        /* scroll close to 10px, automatically fetch and load data with the current search value */
        const isAtBottom = e.target.scrollTop + e.target.offsetHeight >= e.target.scrollHeight - 10;
        if (isAtBottom && hasMoreOptions && !loading) {
            fetchAndLoadData(searchValue, page + 1, true);
        }
    };

    const handleBlur = () => {
        if (!selectedValue) {
            setSearchValue(null);
        }
    };

    const handleChangeOption = (value) => {
        setSelectedValue(value);
        if (reducer && reducer.name && reducer.predicate) {
            const itemSelected = options.find((opt) => reducer.predicate(opt.originalItem, value));
            if (itemSelected) {
                T.dispatch({ type: reducer.name, payload: itemSelected.originalItem });
            }
        }
    };

    /**
     * 
     * @param {JSX.Element} menu 
     * @returns 
     */
    const dropdownRender = (menu) => (
        <>
            {menu}
            {loading && hasMoreOptions && (
                <div style={{ textAlign: 'center', padding: '8px 0' }}>
                    <Spin size='small' />
                </div>
            )}
        </>
    );

    useEffect(() => {
        fetchAndLoadData(searchValue, 1, false);
        return () => {
            if (abortControllerRef.current) {
                abortControllerRef.current.abort();
            }
            debouncedSearch.cancel();
        };
    }, []);

    return <Select showSearch style={style} value={selectedValue} filterOption={false}
        onSearch={handleSearch} onPopupScroll={handlePopupScroll} loading={loading && options.length === 0}
        notFoundContent='Không tìm thấy' disabled={disabled}
        dropdownRender={dropdownRender} options={options} onBlur={handleBlur} onChange={handleChangeOption}
    />;
}
```

---
# References
1. https://lodash.com/docs/4.17.15#debounce