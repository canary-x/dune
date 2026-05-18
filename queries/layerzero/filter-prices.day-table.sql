select
    contract_address
    , blockchain
    , timestamp
    , price
from prices.day
where timestamp >= current_date - interval '20' month
   and blockchain in ('bnb', 'ethereum', 'base', 'arbitrum', 'hemi')