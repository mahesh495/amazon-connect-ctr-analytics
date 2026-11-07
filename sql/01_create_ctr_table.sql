CREATE EXTERNAL TABLE IF NOT EXISTS default.connect_ctr (
  AWSAccountId string,
  AWSContactTraceRecordFormatVersion string,
  Agent struct<
    ARN: string,
    AfterContactWorkDuration: int,
    AfterContactWorkEndTimestamp: string,
    AfterContactWorkStartTimestamp: string,
    AgentInteractionDuration: int,
    ConnectedToAgentTimestamp: string,
    CustomerHoldDuration: int,
    HierarchyGroups: string,
    LongestHoldDuration: int,
    NumberOfHolds: int,
    RoutingProfile: struct<ARN: string, Name: string>,
    Username: string
  >,
  AgentConnectionAttempts int,
  Attributes map<string, string>,
  Channel string,
  ConnectedToSystemTimestamp string,
  ContactId string,
  CustomerEndpoint struct<Address: string, Type: string>,
  DisconnectReason string,
  DisconnectTimestamp string,
  InitialContactId string,
  InitiationMethod string,
  InitiationTimestamp string,
  InstanceARN string,
  LastUpdateTimestamp string,
  MediaStreams array<struct<Type: string>>,
  NextContactId string,
  PreviousContactId string,
  Queue struct<
    ARN: string,
    DequeueTimestamp: string,
    Duration: int,
    EnqueueTimestamp: string,
    Name: string
  >,
  Recording struct<DeletionReason: string, Location: string, Status: string, Type: string>,
  SystemEndpoint struct<Address: string, Type: string>,
  TransferCompletedTimestamp string,
  TransferredToEndpoint struct<Address: string, Type: string>
)
PARTITIONED BY (
  year string,
  month string,
  day string
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
  'ignore.malformed.json' = 'true'
)
LOCATION 's3://<YOUR-CTR-BUCKET-NAME>/ctrs/'
TBLPROPERTIES (
  'projection.enabled' = 'true',
  'projection.year.type' = 'integer',
  'projection.year.range' = '2026,2030',
  'projection.month.type' = 'integer',
  'projection.month.range' = '1,12',
  'projection.month.digits' = '2',
  'projection.day.type' = 'integer',
  'projection.day.range' = '1,31',
  'projection.day.digits' = '2',
  'storage.location.template' = 's3://<YOUR-CTR-BUCKET-NAME>/ctrs/year=${year}/month=${month}/day=${day}/'
);
