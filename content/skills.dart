/// Builder class for defining [Skill]s.
class SkillBuilder extends ContentBuilder {
  final Map<String, Skill> _skills;

  SkillBuilder()
  : _skills = <String, Skill>{};

  Map<String, Skill> build() {
    skill(new CombatSkill());
    skill(new StaminaSkill());
    skill(new WeaponSkill('Club'));
    skill(new WeaponSkill('Dagger'));

    return _skills;
  }

  void skill(Skill skill) {
    _skills[skill.name] = skill;
  }
}

class CombatSkill extends Skill {
  String get name => 'Combat';
  String getHelpText(int level) => 'Increase damage by $level.';

  num getAttackAddBonus(int level, Item weapon, Attack attack) => level;
}

class WeaponSkill extends Skill {
  final String _category;

  WeaponSkill(this._category);

  String get name => '$_category Mastery';
  String getHelpText(int level) =>
      'Increase damage by ${level * 5}% when wielding a $_category.';

  num getAttackMultiplyBonus(int level, Item weapon, Attack attack) {
    if (weapon == null || weapon.type.category != _category) return 0;
    return level * 5 / 100;
  }
}

class StaminaSkill extends Skill {
  String get name => 'Stamina';
  String getHelpText(int level) => 'Increase max health by ${level * 2}.';

  int modifyHealth(int level) => level * 2;
}