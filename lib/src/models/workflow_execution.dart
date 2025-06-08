import 'package:json_annotation/json_annotation.dart';

part 'workflow_execution.g.dart';

/// Workflow execution status
enum WorkflowExecutionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('running')
  running,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('canceled')
  canceled,
  @JsonValue('waiting')
  waiting,
}

/// Workflow step status
enum WorkflowStepStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('running')
  running,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('skipped')
  skipped,
  @JsonValue('waiting')
  waiting,
}

/// Workflow step execution model
@JsonSerializable()
class WorkflowStepExecution {
  final String id;
  final String workflowExecutionId;
  final String stepId;
  final String stepName;
  final WorkflowStepStatus status;
  final Map<String, dynamic>? input;
  final Map<String, dynamic>? output;
  final Map<String, dynamic>? error;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int? retryCount;
  final int? maxRetries;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkflowStepExecution({
    required this.id,
    required this.workflowExecutionId,
    required this.stepId,
    required this.stepName,
    required this.status,
    this.input,
    this.output,
    this.error,
    this.startedAt,
    this.completedAt,
    this.retryCount,
    this.maxRetries,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkflowStepExecution.fromJson(Map<String, dynamic> json) =>
      _$WorkflowStepExecutionFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowStepExecutionToJson(this);

  /// Check if step is pending
  bool get isPending => status == WorkflowStepStatus.pending;

  /// Check if step is running
  bool get isRunning => status == WorkflowStepStatus.running;

  /// Check if step is completed
  bool get isCompleted => status == WorkflowStepStatus.completed;

  /// Check if step failed
  bool get hasFailed => status == WorkflowStepStatus.failed;

  /// Check if step was skipped
  bool get wasSkipped => status == WorkflowStepStatus.skipped;

  /// Check if step is waiting
  bool get isWaiting => status == WorkflowStepStatus.waiting;

  /// Get execution duration in milliseconds
  int? get executionDurationMs {
    if (startedAt == null || completedAt == null) return null;
    return completedAt!.difference(startedAt!).inMilliseconds;
  }

  /// Check if step can be retried
  bool get canRetry {
    if (maxRetries == null) return false;
    return (retryCount ?? 0) < maxRetries!;
  }
}

/// Workflow execution model for Medusa v2
@JsonSerializable()
class WorkflowExecution {
  final String id;
  final String workflowId;
  final String workflowName;
  final String? workflowVersion;
  final WorkflowExecutionStatus status;
  final Map<String, dynamic>? input;
  final Map<String, dynamic>? output;
  final Map<String, dynamic>? context;
  final Map<String, dynamic>? error;
  final String? parentExecutionId;
  final String? triggeredBy;
  final List<WorkflowStepExecution>? steps;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkflowExecution({
    required this.id,
    required this.workflowId,
    required this.workflowName,
    this.workflowVersion,
    required this.status,
    this.input,
    this.output,
    this.context,
    this.error,
    this.parentExecutionId,
    this.triggeredBy,
    this.steps,
    this.startedAt,
    this.completedAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkflowExecution.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionToJson(this);

  /// Check if execution is pending
  bool get isPending => status == WorkflowExecutionStatus.pending;

  /// Check if execution is running
  bool get isRunning => status == WorkflowExecutionStatus.running;

  /// Check if execution is completed
  bool get isCompleted => status == WorkflowExecutionStatus.completed;

  /// Check if execution failed
  bool get hasFailed => status == WorkflowExecutionStatus.failed;

  /// Check if execution was canceled
  bool get wasCanceled => status == WorkflowExecutionStatus.canceled;

  /// Check if execution is waiting
  bool get isWaiting => status == WorkflowExecutionStatus.waiting;

  /// Check if execution is in progress
  bool get isInProgress => isRunning || isWaiting;

  /// Check if execution is terminal (completed, failed, or canceled)
  bool get isTerminal => isCompleted || hasFailed || wasCanceled;

  /// Get execution duration in milliseconds
  int? get executionDurationMs {
    if (startedAt == null) return null;
    final endTime = completedAt ?? DateTime.now();
    return endTime.difference(startedAt!).inMilliseconds;
  }

  /// Get progress percentage (completed steps / total steps)
  double get progressPercentage {
    if (steps == null || steps!.isEmpty) return 0.0;
    final completedSteps = steps!.where((step) => step.isCompleted).length;
    return completedSteps / steps!.length;
  }

  /// Get count of failed steps
  int get failedStepsCount {
    if (steps == null) return 0;
    return steps!.where((step) => step.hasFailed).length;
  }

  /// Get count of pending steps
  int get pendingStepsCount {
    if (steps == null) return 0;
    return steps!.where((step) => step.isPending).length;
  }

  /// Get count of completed steps
  int get completedStepsCount {
    if (steps == null) return 0;
    return steps!.where((step) => step.isCompleted).length;
  }
}

/// Execute workflow request
@JsonSerializable()
class ExecuteWorkflowRequest {
  final String workflowId;
  final Map<String, dynamic>? input;
  final Map<String, dynamic>? context;
  final String? triggeredBy;
  final Map<String, dynamic>? metadata;

  const ExecuteWorkflowRequest({
    required this.workflowId,
    this.input,
    this.context,
    this.triggeredBy,
    this.metadata,
  });

  factory ExecuteWorkflowRequest.fromJson(Map<String, dynamic> json) =>
      _$ExecuteWorkflowRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExecuteWorkflowRequestToJson(this);
}

/// Cancel workflow execution request
@JsonSerializable()
class CancelWorkflowExecutionRequest {
  final String? reason;

  const CancelWorkflowExecutionRequest({this.reason});

  factory CancelWorkflowExecutionRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelWorkflowExecutionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelWorkflowExecutionRequestToJson(this);
}

/// Retry workflow execution request
@JsonSerializable()
class RetryWorkflowExecutionRequest {
  final String? fromStepId;
  final Map<String, dynamic>? input;

  const RetryWorkflowExecutionRequest({this.fromStepId, this.input});

  factory RetryWorkflowExecutionRequest.fromJson(Map<String, dynamic> json) =>
      _$RetryWorkflowExecutionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RetryWorkflowExecutionRequestToJson(this);
}

/// Workflow execution response
@JsonSerializable()
class WorkflowExecutionResponse {
  final WorkflowExecution workflowExecution;

  const WorkflowExecutionResponse({required this.workflowExecution});

  factory WorkflowExecutionResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionResponseToJson(this);
}

/// Workflow executions response
@JsonSerializable()
class WorkflowExecutionsResponse {
  final List<WorkflowExecution> workflowExecutions;
  final int count;
  final int offset;
  final int limit;

  const WorkflowExecutionsResponse({
    required this.workflowExecutions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory WorkflowExecutionsResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowExecutionsResponseToJson(this);
}
