class TaskOption {
  final String option;
  final bool checked;

  TaskOption({
    this.option,
    this.checked,
  });

  TaskOption.fromMap(Map<String, dynamic> data)
      : this.option = data["option"],
        this.checked = data["checked"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'option': this.option ?? "",
      'checked': this.checked ?? false,
    };
  }
}
