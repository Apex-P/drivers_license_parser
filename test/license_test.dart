import 'package:drivers_license_parser/src/license.dart';
import 'package:drivers_license_parser/src/postal_code.dart';
import 'package:test/test.dart';

void main() {
  group("License", () {
    group("Equality", () {
      test("should be equal when all fields match", () {
        var left = License(
          driversLicenseNumber: "D123",
          firstName: "JANE",
          lastName: "DOE",
          middleName: "Q",
          expirationDate: DateTime(2030, 1, 1),
          issueDate: DateTime(2020, 1, 1),
          dateOfBirth: DateTime(1990, 1, 1),
          height: 65.0,
          streetAddress: "123 MAIN ST",
          city: "ANYTOWN",
          state: "CA",
          postalCode: PostalCode(postalCode: "12345", extension: "6789"),
          documentId: "DOC-1",
          version: "8",
          pdf417: "raw",
        );
        var right = License(
          driversLicenseNumber: "D123",
          firstName: "JANE",
          lastName: "DOE",
          middleName: "Q",
          expirationDate: DateTime(2030, 1, 1),
          issueDate: DateTime(2020, 1, 1),
          dateOfBirth: DateTime(1990, 1, 1),
          height: 65.0,
          streetAddress: "123 MAIN ST",
          city: "ANYTOWN",
          state: "CA",
          postalCode: PostalCode(postalCode: "12345", extension: "6789"),
          documentId: "DOC-1",
          version: "8",
          pdf417: "raw",
        );

        expect(left, equals(right));
        expect(left.hashCode, equals(right.hashCode));
      });

      test("should not be equal when a field differs", () {
        var left = License(driversLicenseNumber: "D123", firstName: "JANE");
        var right = License(driversLicenseNumber: "D123", firstName: "JOAN");

        expect(left == right, isFalse);
      });
    });

    group("Acceptability", () {
      group("when the license has yet to be issued", () {
        test("should not be acceptable", () {
          var sut = License(
            issueDate: DateTime(2900, 1, 1),
            driversLicenseNumber: "any",
          );
          expect(sut.isAcceptable(), isFalse);
        });
      });
      group("when the license is expired", () {
        test("should not be acceptable", () {
          var sut = License(
            expirationDate: DateTime(1900, 1, 1),
            driversLicenseNumber: "any",
          );
          expect(sut.isAcceptable(), isFalse);
        });
      });
      group("when all essential fields are present", () {
        test("should be acceptable", () {
          var sut = License(
            driversLicenseNumber: "any",
            expirationDate: DateTime(3000, 1, 1),
            lastName: "SOMETHING",
            firstName: "SOMETHING",
            middleName: "SOMETHING",
            issueDate: DateTime(2000, 1, 1),
            dateOfBirth: DateTime(1970, 1, 1),
            height: 65.0,
            streetAddress: "SOMETHING",
            city: "SOMETHING",
            state: "CA",
            postalCode: PostalCode(postalCode: "12345", extension: "6789"),
            documentId: "SOMETHING",
          );
          expect(sut.isAcceptable(), isTrue);
        });
      });
    });
  });
}
