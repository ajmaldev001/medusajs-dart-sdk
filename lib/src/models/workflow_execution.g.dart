// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowStepExecution _$WorkflowStepExecutionFromJson(
  Map<String, dynamic> json,
) => WorkflowStepExecution(
  id: json['id'] as String,
  workflowExecutionId: json['workflowExecutionId'] as String,
  stepId: json['stepId'] as String,
  stepName: json['stepName'] as String,
  status: $enumDecode(_$WorkflowStepStatusEnumMap, json['status']),
  input: json['input'] as Map<String, dynamic>?,
  output: json['output'] as Map<String, dynamic>?,
  error: json['error'] as Map<String, dynamic>?,
  startedAt:
      json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
  retryCount: (json['retryCount'] as num?)?.toInt(),
  maxRetries: (json['maxRetries'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$WorkflowStepExecutionToJson(
  WorkflowStepExecution instance,
) => <String, dynamic>{
  'id': instance.id,
  'workflowExecutionId': instance.workflowExecutionId,
  'stepId': instance.stepId,
  'stepName': instance.stepName,
  'status': _$WorkflowStepStatusEnumMap[instance.status]!,
  'input': instance.input,
  'output': instance.output,
  'error': instance.error,
  'startedAt': instance.startedAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'retryCount': instance.retryCount,
  'maxRetries': instance.maxRetries,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$WorkflowStepStatusEnumMap = {
  WorkflowStepStatus.pending: 'pending',
  WorkflowStepStatus.running: 'running',
  WorkflowStepStatus.completed: 'completed',
  WorkflowStepStatus.failed: 'failed',
  WorkflowStepStatus.skipped: 'skipped',
  WorkflowStepStatus.waiting: 'waiting',
};

WorkflowExecution _$WorkflowExecutionFromJson(Map<String, dynamic> json) =>
    WorkflowExecution(
      id: json['id'] as String,
      workflowId: json['workflowId'] as String,
      workflowName: json['workflowName'] as String,
      workflowVersion: json['workflowVersion'] as String?,
      status: $enumDecode(_$WorkflowExecutionStatusEnumMap, json['status']),
      input: json['input'] as Map<String, dynamic>?,
      output: json['output'] as Map<String, dynamic>?,
      context: json['context'] as Map<String, dynamic>?,
      error: json['error'] as Map<String, dynamic>?,
      parentExecutionId: json['parentExecutionId'] as String?,
      triggeredBy: json['triggeredBy'] as String?,
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map(
                (e) =>
                    WorkflowStepExecution.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      startedAt:
          json['startedAt'] == null
              ? null
              : DateTime.parse(json['startedAt'] as String),
      completedAt:
          json['completedAt'] == null
              ? null
              : DateTime.parse(json['completedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WorkflowExecutionToJson(WorkflowExecution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workflowId': instance.workflowId,
      'workflowName': instance.workflowName,
      'workflowVersion': instance.workflowVersion,
      'status': _$WorkflowExecutionStatusEnumMap[instance.status]!,
      'input': instance.input,
      'output': instance.output,
      'context': instance.context,
      'error': instance.error,
      'parentExecutionId': instance.parentExecutionId,
      'triggeredBy': instance.triggeredBy,
      'steps': instance.steps,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$WorkflowExecutionStatusEnumMap = {
  WorkflowExecutionStatus.pending: 'pending',
  WorkflowExecutionStatus.running: 'running',
  WorkflowExecutionStatus.completed: 'completed',
  WorkflowExecutionStatus.failed: 'failed',
  WorkflowExecutionStatus.canceled: 'canceled',
  WorkflowExecutionStatus.waiting: 'waiting',
};

ExecuteWorkflowRequest _$ExecuteWorkflowRequestFromJson(
  Map<String, dynamic> json,
) => ExecuteWorkflowRequest(
  workflowId: json['workflowId'] as String,
  input: json['input'] as Map<String, dynamic>?,
  context: json['context'] as Map<String, dynamic>?,
  triggeredBy: json['triggeredBy'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ExecuteWorkflowRequestToJson(
  ExecuteWorkflowRequest instance,
) => <String, dynamic>{
  'workflowId': instance.workflowId,
  'input': instance.input,
  'context': instance.context,
  'triggeredBy': instance.triggeredBy,
  'metadata': instance.metadata,
};

CancelWorkflowExecutionRequest _$CancelWorkflowExecutionRequestFromJson(
  Map<String, dynamic> json,
) => CancelWorkflowExecutionRequest(reason: json['reason'] as String?);

Map<String, dynamic> _$CancelWorkflowExecutionRequestToJson(
  CancelWorkflowExecutionRequest instance,
) => <String, dynamic>{'reason': instance.reason};

RetryWorkflowExecutionRequest _$RetryWorkflowExecutionRequestFromJson(
  Map<String, dynamic> json,
) => RetryWorkflowExecutionRequest(
  fromStepId: json['fromStepId'] as String?,
  input: json['input'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RetryWorkflowExecutionRequestToJson(
  RetryWorkflowExecutionRequest instance,
) => <String, dynamic>{
  'fromStepId': instance.fromStepId,
  'input': instance.input,
};

WorkflowExecutionResponse _$WorkflowExecutionResponseFromJson(
  Map<String, dynamic> json,
) => WorkflowExecutionResponse(
  workflowExecution: WorkflowExecution.fromJson(
    json['workflowExecution'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$WorkflowExecutionResponseToJson(
  WorkflowExecutionResponse instance,
) => <String, dynamic>{'workflowExecution': instance.workflowExecution};

WorkflowExecutionsResponse _$WorkflowExecutionsResponseFromJson(
  Map<String, dynamic> json,
) => WorkflowExecutionsResponse(
  workflowExecutions:
      (json['workflowExecutions'] as List<dynamic>)
          .map((e) => WorkflowExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
  count: (json['count'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$WorkflowExecutionsResponseToJson(
  WorkflowExecutionsResponse instance,
) => <String, dynamic>{
  'workflowExecutions': instance.workflowExecutions,
  'count': instance.count,
  'offset': instance.offset,
  'limit': instance.limit,
};
