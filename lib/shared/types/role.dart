enum Role { client, professional }

extension RoleDisplay on Role {
  String get label => switch (this) {
        Role.client => 'Client',
        Role.professional => 'Professional',
      };
}
