// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowStepExecution _$WorkflowStepExecutionFromJson(
  Map<String, dynamic> json,
) => WorkflowStepExecution(
  id: json['id'] as String,
  workflowExecutionId: json['workflow_execution_id'] as String,
  stepId: json['step_id'] as String,
  stepName: json['step_name'] as String,
  status: $enumDecode(_$WorkflowStepStatusEnumMap, json['status']),
  input: json['input'] as Map<String, dynamic>?,
  output: json['output'] as Map<String, dynamic>?,
  error: json['error'] as Map<String, dynamic>?,
  startedAt:
      json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
  completedAt:
      json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
  retryCount: (json['retry_count'] as num?)?.toInt(),
  maxRetries: (json['max_retries'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$WorkflowStepExecutionToJson(
  WorkflowStepExecution instance,
) => <String, dynamic>{
  'id': instance.id,
  'workflow_execution_id': instance.workflowExecutionId,
  'step_id': instance.stepId,
  'step_name': instance.stepName,
  'status': _$WorkflowStepStatusEnumMap[instance.status]!,
  'input': instance.input,
  'output': instance.output,
  'error': instance.error,
  'started_at': instance.startedAt?.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
  'retry_count': instance.retryCount,
  'max_retries': instance.maxRetries,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
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
      workflowId: json['workflow_id'] as String,
      workflowName: json['workflow_name'] as String,
      workflowVersion: json['workflow_version'] as String?,
      status: $enumDecode(_$WorkflowExecutionStatusEnumMap, json['status']),
      input: json['input'] as Map<String, dynamic>?,
      output: json['output'] as Map<String, dynamic>?,
      context: json['context'] as Map<String, dynamic>?,
      error: json['error'] as Map<String, dynamic>?,
      parentExecutionId: json['parent_execution_id'] as String?,
      triggeredBy: json['triggered_by'] as String?,
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map(
                (e) =>
                    WorkflowStepExecution.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      startedAt:
          json['started_at'] == null
              ? null
              : DateTime.parse(json['started_at'] as String),
      completedAt:
          json['completed_at'] == null
              ? null
              : DateTime.parse(json['completed_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$WorkflowExecutionToJson(WorkflowExecution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workflow_id': instance.workflowId,
      'workflow_name': instance.workflowName,
      'workflow_version': instance.workflowVersion,
      'status': _$WorkflowExecutionStatusEnumMap[instance.status]!,
      'input': instance.input,
      'output': instance.output,
      'context': instance.context,
      'error': instance.error,
      'parent_execution_id': instance.parentExecutionId,
      'triggered_by': instance.triggeredBy,
      'steps': instance.steps,
      'started_at': instance.startedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
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
  workflowId: json['workflow_id'] as String,
  input: json['input'] as Map<String, dynamic>?,
  context: json['context'] as Map<String, dynamic>?,
  triggeredBy: json['triggered_by'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ExecuteWorkflowRequestToJson(
  ExecuteWorkflowRequest instance,
) => <String, dynamic>{
  'workflow_id': instance.workflowId,
  'input': instance.input,
  'context': instance.context,
  'triggered_by': instance.triggeredBy,
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
  fromStepId: json['from_step_id'] as String?,
  input: json['input'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RetryWorkflowExecutionRequestToJson(
  RetryWorkflowExecutionRequest instance,
) => <String, dynamic>{
  'from_step_id': instance.fromStepId,
  'input': instance.input,
};

WorkflowExecutionResponse _$WorkflowExecutionResponseFromJson(
  Map<String, dynamic> json,
) => WorkflowExecutionResponse(
  workflowExecution: WorkflowExecution.fromJson(
    json['workflow_execution'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$WorkflowExecutionResponseToJson(
  WorkflowExecutionResponse instance,
) => <String, dynamic>{'workflow_execution': instance.workflowExecution};

WorkflowExecutionsResponse _$WorkflowExecutionsResponseFromJson(
  Map<String, dynamic> json,
) => WorkflowExecutionsResponse(
  workflowExecutions:
      (json['workflow_executions'] as List<dynamic>)
          .map((e) => WorkflowExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
  count: (json['count'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$WorkflowExecutionsResponseToJson(
  WorkflowExecutionsResponse instance,
) => <String, dynamic>{
  'workflow_executions': instance.workflowExecutions,
  'count': instance.count,
  'offset': instance.offset,
  'limit': instance.limit,
};
