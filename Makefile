# Flutter Playground Build Tool
# This Makefile automates Flutter commands across all projects

# Set shell explicitly
SHELL := /bin/bash

# Project directories
PROJECTS := HelloFlutter/hello_flutter \
            01-Flutter-Widgets \
            02-Flutter-UI-Components \
            03-Flutter-Design-Animations \
            04-Flutter-Forms-Gestures \
            05-Flutter-Navigation-Routing \
            06-Flutter-Accessing-Device \
            07-Flutter-Advanced-Concepts \
            21-Quiz-App \
            22-Flutter-Magic-8-Ball-App \
            23-TaskFlow

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Enable color output
export TERM=xterm-256color

# Default target
.PHONY: all
all: doctor pub-get analyze test build-android build-ios

# Check Flutter installation and dependencies
.PHONY: doctor
doctor:
	@printf "$(GREEN)=== Running flutter doctor for all projects ===$(NC)\n"
	@printf "$(YELLOW)--- HelloFlutter/hello_flutter ---$(NC)\n"
	@if [ -d "HelloFlutter/hello_flutter" ]; then \
		cd "HelloFlutter/hello_flutter" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory HelloFlutter/hello_flutter not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 01-Flutter-Widgets ---$(NC)\n"
	@if [ -d "01-Flutter-Widgets" ]; then \
		cd "01-Flutter-Widgets" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 01-Flutter-Widgets not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 02-Flutter-UI-Components ---$(NC)\n"
	@if [ -d "02-Flutter-UI-Components" ]; then \
		cd "02-Flutter-UI-Components" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 02-Flutter-UI-Components not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 03-Flutter-Design-Animations ---$(NC)\n"
	@if [ -d "03-Flutter-Design-Animations" ]; then \
		cd "03-Flutter-Design-Animations" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 03-Flutter-Design-Animations not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 04-Flutter-Forms-Gestures ---$(NC)\n"
	@if [ -d "04-Flutter-Forms-Gestures" ]; then \
		cd "04-Flutter-Forms-Gestures" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 04-Flutter-Forms-Gestures not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 05-Flutter-Navigation-Routing ---$(NC)\n"
	@if [ -d "05-Flutter-Navigation-Routing" ]; then \
		cd "05-Flutter-Navigation-Routing" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 05-Flutter-Navigation-Routing not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 06-Flutter-Accessing-Device ---$(NC)\n"
	@if [ -d "06-Flutter-Accessing-Device" ]; then \
		cd "06-Flutter-Accessing-Device" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 06-Flutter-Accessing-Device not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 07-Flutter-Advanced-Concepts ---$(NC)\n"
	@if [ -d "07-Flutter-Advanced-Concepts" ]; then \
		cd "07-Flutter-Advanced-Concepts" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 07-Flutter-Advanced-Concepts not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 21-Quiz-App ---$(NC)\n"
	@if [ -d "21-Quiz-App" ]; then \
		cd "21-Quiz-App" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 21-Quiz-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 22-Flutter-Magic-8-Ball-App ---$(NC)\n"
	@if [ -d "22-Flutter-Magic-8-Ball-App" ]; then \
		cd "22-Flutter-Magic-8-Ball-App" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 22-Flutter-Magic-8-Ball-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 23-TaskFlow ---$(NC)\n"
	@if [ -d "23-TaskFlow" ]; then \
		cd "23-TaskFlow" && flutter doctor -v && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 23-TaskFlow not found$(NC)\n"; \
	fi


# Get dependencies for all projects
.PHONY: pub-get
pub-get:
	@printf "$(GREEN)=== Getting dependencies for all projects ===$(NC)\n"
	@printf "$(YELLOW)--- HelloFlutter/hello_flutter ---$(NC)\n"
	@if [ -d "HelloFlutter/hello_flutter" ]; then \
		cd "HelloFlutter/hello_flutter" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory HelloFlutter/hello_flutter not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 01-Flutter-Widgets ---$(NC)\n"
	@if [ -d "01-Flutter-Widgets" ]; then \
		cd "01-Flutter-Widgets" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 01-Flutter-Widgets not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 02-Flutter-UI-Components ---$(NC)\n"
	@if [ -d "02-Flutter-UI-Components" ]; then \
		cd "02-Flutter-UI-Components" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 02-Flutter-UI-Components not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 03-Flutter-Design-Animations ---$(NC)\n"
	@if [ -d "03-Flutter-Design-Animations" ]; then \
		cd "03-Flutter-Design-Animations" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 03-Flutter-Design-Animations not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 04-Flutter-Forms-Gestures ---$(NC)\n"
	@if [ -d "04-Flutter-Forms-Gestures" ]; then \
		cd "04-Flutter-Forms-Gestures" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 04-Flutter-Forms-Gestures not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 05-Flutter-Navigation-Routing ---$(NC)\n"
	@if [ -d "05-Flutter-Navigation-Routing" ]; then \
		cd "05-Flutter-Navigation-Routing" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 05-Flutter-Navigation-Routing not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 06-Flutter-Accessing-Device ---$(NC)\n"
	@if [ -d "06-Flutter-Accessing-Device" ]; then \
		cd "06-Flutter-Accessing-Device" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 06-Flutter-Accessing-Device not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 07-Flutter-Advanced-Concepts ---$(NC)\n"
	@if [ -d "07-Flutter-Advanced-Concepts" ]; then \
		cd "07-Flutter-Advanced-Concepts" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 07-Flutter-Advanced-Concepts not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 21-Quiz-App ---$(NC)\n"
	@if [ -d "21-Quiz-App" ]; then \
		cd "21-Quiz-App" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 21-Quiz-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 22-Flutter-Magic-8-Ball-App ---$(NC)\n"
	@if [ -d "22-Flutter-Magic-8-Ball-App" ]; then \
		cd "22-Flutter-Magic-8-Ball-App" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 22-Flutter-Magic-8-Ball-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 23-TaskFlow ---$(NC)\n"
	@if [ -d "23-TaskFlow" ]; then \
		cd "23-TaskFlow" && flutter pub get && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 23-TaskFlow not found$(NC)\n"; \
	fi


# Analyze all projects
.PHONY: analyze
analyze:
	@printf "$(GREEN)=== Analyzing all projects ===$(NC)\n"
	@printf "$(YELLOW)--- HelloFlutter/hello_flutter ---$(NC)\n"
	@if [ -d "HelloFlutter/hello_flutter" ]; then \
		cd "HelloFlutter/hello_flutter" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory HelloFlutter/hello_flutter not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 01-Flutter-Widgets ---$(NC)\n"
	@if [ -d "01-Flutter-Widgets" ]; then \
		cd "01-Flutter-Widgets" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 01-Flutter-Widgets not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 02-Flutter-UI-Components ---$(NC)\n"
	@if [ -d "02-Flutter-UI-Components" ]; then \
		cd "02-Flutter-UI-Components" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 02-Flutter-UI-Components not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 03-Flutter-Design-Animations ---$(NC)\n"
	@if [ -d "03-Flutter-Design-Animations" ]; then \
		cd "03-Flutter-Design-Animations" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 03-Flutter-Design-Animations not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 04-Flutter-Forms-Gestures ---$(NC)\n"
	@if [ -d "04-Flutter-Forms-Gestures" ]; then \
		cd "04-Flutter-Forms-Gestures" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 04-Flutter-Forms-Gestures not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 05-Flutter-Navigation-Routing ---$(NC)\n"
	@if [ -d "05-Flutter-Navigation-Routing" ]; then \
		cd "05-Flutter-Navigation-Routing" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 05-Flutter-Navigation-Routing not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 06-Flutter-Accessing-Device ---$(NC)\n"
	@if [ -d "06-Flutter-Accessing-Device" ]; then \
		cd "06-Flutter-Accessing-Device" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 06-Flutter-Accessing-Device not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 07-Flutter-Advanced-Concepts ---$(NC)\n"
	@if [ -d "07-Flutter-Advanced-Concepts" ]; then \
		cd "07-Flutter-Advanced-Concepts" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 07-Flutter-Advanced-Concepts not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 21-Quiz-App ---$(NC)\n"
	@if [ -d "21-Quiz-App" ]; then \
		cd "21-Quiz-App" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 21-Quiz-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 22-Flutter-Magic-8-Ball-App ---$(NC)\n"
	@if [ -d "22-Flutter-Magic-8-Ball-App" ]; then \
		cd "22-Flutter-Magic-8-Ball-App" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 22-Flutter-Magic-8-Ball-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 23-TaskFlow ---$(NC)\n"
	@if [ -d "23-TaskFlow" ]; then \
		cd "23-TaskFlow" && flutter analyze && cd - > /dev/null || true; \
	else \
		printf "$(RED)Directory 23-TaskFlow not found$(NC)\n"; \
	fi

# Test all projects
.PHONY: test
test:
	@printf "$(GREEN)=== Running tests for all projects ===$(NC)\n"
	@printf "$(YELLOW)--- HelloFlutter/hello_flutter ---$(NC)\n"
	@if [ -d "HelloFlutter/hello_flutter" ]; then \
		cd "HelloFlutter/hello_flutter" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory HelloFlutter/hello_flutter not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 01-Flutter-Widgets ---$(NC)\n"
	@if [ -d "01-Flutter-Widgets" ]; then \
		cd "01-Flutter-Widgets" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 01-Flutter-Widgets not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 02-Flutter-UI-Components ---$(NC)\n"
	@if [ -d "02-Flutter-UI-Components" ]; then \
		cd "02-Flutter-UI-Components" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 02-Flutter-UI-Components not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 03-Flutter-Design-Animations ---$(NC)\n"
	@if [ -d "03-Flutter-Design-Animations" ]; then \
		cd "03-Flutter-Design-Animations" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 03-Flutter-Design-Animations not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 04-Flutter-Forms-Gestures ---$(NC)\n"
	@if [ -d "04-Flutter-Forms-Gestures" ]; then \
		cd "04-Flutter-Forms-Gestures" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 04-Flutter-Forms-Gestures not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 05-Flutter-Navigation-Routing ---$(NC)\n"
	@if [ -d "05-Flutter-Navigation-Routing" ]; then \
		cd "05-Flutter-Navigation-Routing" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 05-Flutter-Navigation-Routing not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 06-Flutter-Accessing-Device ---$(NC)\n"
	@if [ -d "06-Flutter-Accessing-Device" ]; then \
		cd "06-Flutter-Accessing-Device" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 06-Flutter-Accessing-Device not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 07-Flutter-Advanced-Concepts ---$(NC)\n"
	@if [ -d "07-Flutter-Advanced-Concepts" ]; then \
		cd "07-Flutter-Advanced-Concepts" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 07-Flutter-Advanced-Concepts not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 21-Quiz-App ---$(NC)\n"
	@if [ -d "21-Quiz-App" ]; then \
		cd "21-Quiz-App" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 21-Quiz-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 22-Flutter-Magic-8-Ball-App ---$(NC)\n"
	@if [ -d "22-Flutter-Magic-8-Ball-App" ]; then \
		cd "22-Flutter-Magic-8-Ball-App" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 22-Flutter-Magic-8-Ball-App not found$(NC)\n"; \
	fi
	@echo ""
	@printf "$(YELLOW)--- 23-TaskFlow ---$(NC)\n"
	@if [ -d "23-TaskFlow" ]; then \
		cd "23-TaskFlow" && flutter test && cd - > /dev/null; \
	else \
		printf "$(RED)Directory 23-TaskFlow not found$(NC)\n"; \
	fi


# Build Android APK for all projects
.PHONY: build-android
build-android:
	@printf "$(GREEN)=== Building Android APK for all projects ===$(NC)\n"
	@for project in $(PROJECTS); do \
		printf "$(YELLOW)--- $$project ---$(NC)\n"; \
		printf "$(GREEN)start building project $$project...$(NC)\n"; \
		if [ -d "$$project" ]; then \
			cd "$$project" && flutter build apk --release && cd - > /dev/null; \
			printf "$(GREEN)finished building project $$project$(NC)\n"; \
		else \
			printf "$(RED)Directory $$project not found$(NC)\n"; \
		fi; \
		echo ""; \
	done

# Build iOS for all projects (debug, no codesign)
.PHONY: build-ios
build-ios:
	@printf "$(GREEN)=== Building iOS for all projects ===$(NC)\n"
	@for project in $(PROJECTS); do \
		printf "$(YELLOW)--- $$project ---$(NC)\n"; \
		if [ -d "$$project" ]; then \
			cd "$$project" && flutter build ios --debug --no-codesign && cd - > /dev/null; \
		else \
			printf "$(RED)Directory $$project not found$(NC)\n"; \
		fi; \
		echo ""; \
	done

# Clean all projects
.PHONY: clean
clean:
	@printf "$(GREEN)=== Cleaning all projects ===$(NC)\n"
	@for project in $(PROJECTS); do \
		printf "$(YELLOW)--- $$project ---$(NC)\n"; \
		if [ -d "$$project" ]; then \
			cd "$$project" && flutter clean && cd - > /dev/null; \
		else \
			printf "$(RED)Directory $$project not found$(NC)\n"; \
		fi; \
		echo ""; \
	done

# Individual project targets
.PHONY: hello-flutter
hello-flutter:
	@printf "$(GREEN)=== HelloFlutter Project ===$(NC)\n"
	@printf "$(GREEN)start building project HelloFlutter/hello_flutter...$(NC)\n"
	@if [ -d "HelloFlutter/hello_flutter" ]; then \
		cd HelloFlutter/hello_flutter && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project HelloFlutter/hello_flutter$(NC)\n"; \
	else \
		printf "$(RED)Directory HelloFlutter/hello_flutter not found$(NC)\n"; \
	fi

.PHONY: project-01
project-01:
	@printf "$(GREEN)=== 01-Flutter-Widgets Project ===$(NC)\n"
	@printf "$(GREEN)start building project 01-Flutter-Widgets...$(NC)\n"
	@if [ -d "01-Flutter-Widgets" ]; then \
		cd 01-Flutter-Widgets && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 01-Flutter-Widgets$(NC)\n"; \
	else \
		printf "$(RED)Directory 01-Flutter-Widgets not found$(NC)\n"; \
	fi

.PHONY: project-02
project-02:
	@printf "$(GREEN)=== 02-Flutter-UI-Components Project ===$(NC)\n"
	@printf "$(GREEN)start building project 02-Flutter-UI-Components...$(NC)\n"
	@if [ -d "02-Flutter-UI-Components" ]; then \
		cd 02-Flutter-UI-Components && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 02-Flutter-UI-Components$(NC)\n"; \
	else \
		printf "$(RED)Directory 02-Flutter-UI-Components not found$(NC)\n"; \
	fi

.PHONY: project-03
project-03:
	@printf "$(GREEN)=== 03-Flutter-Design-Animations Project ===$(NC)\n"
	@printf "$(GREEN)start building project 03-Flutter-Design-Animations...$(NC)\n"
	@if [ -d "03-Flutter-Design-Animations" ]; then \
		cd 03-Flutter-Design-Animations && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 03-Flutter-Design-Animations$(NC)\n"; \
	else \
		printf "$(RED)Directory 03-Flutter-Design-Animations not found$(NC)\n"; \
	fi

.PHONY: project-04
project-04:
	@printf "$(GREEN)=== 04-Flutter-Forms-Gestures Project ===$(NC)\n"
	@printf "$(GREEN)start building project 04-Flutter-Forms-Gestures...$(NC)\n"
	@if [ -d "04-Flutter-Forms-Gestures" ]; then \
		cd 04-Flutter-Forms-Gestures && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 04-Flutter-Forms-Gestures$(NC)\n"; \
	else \
		printf "$(RED)Directory 04-Flutter-Forms-Gestures not found$(NC)\n"; \
	fi

.PHONY: project-05
project-05:
	@printf "$(GREEN)=== 05-Flutter-Navigation-Routing Project ===$(NC)\n"
	@printf "$(GREEN)start building project 05-Flutter-Navigation-Routing...$(NC)\n"
	@if [ -d "05-Flutter-Navigation-Routing" ]; then \
		cd 05-Flutter-Navigation-Routing && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 05-Flutter-Navigation-Routing$(NC)\n"; \
	else \
		printf "$(RED)Directory 05-Flutter-Navigation-Routing not found$(NC)\n"; \
	fi

.PHONY: project-06
project-06:
	@printf "$(GREEN)=== 06-Flutter-Accessing-Device Project ===$(NC)\n"
	@printf "$(GREEN)start building project 06-Flutter-Accessing-Device...$(NC)\n"
	@if [ -d "06-Flutter-Accessing-Device" ]; then \
		cd 06-Flutter-Accessing-Device && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 06-Flutter-Accessing-Device$(NC)\n"; \
	else \
		printf "$(RED)Directory 06-Flutter-Accessing-Device not found$(NC)\n"; \
	fi

.PHONY: project-07
project-07:
	@printf "$(GREEN)=== 07-Flutter-Advanced-Concepts Project ===$(NC)\n"
	@printf "$(GREEN)start building project 07-Flutter-Advanced-Concepts...$(NC)\n"
	@if [ -d "07-Flutter-Advanced-Concepts" ]; then \
		cd 07-Flutter-Advanced-Concepts && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 07-Flutter-Advanced-Concepts$(NC)\n"; \
	else \
		printf "$(RED)Directory 07-Flutter-Advanced-Concepts not found$(NC)\n"; \
	fi





.PHONY: project-21
project-21:
	@printf "$(GREEN)=== 21-Quiz-App Project ===$(NC)\n"
	@printf "$(GREEN)start building project 21-Quiz-App...$(NC)\n"
	@if [ -d "21-Quiz-App" ]; then \
		cd 21-Quiz-App && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 21-Quiz-App$(NC)\n"; \
	else \
		printf "$(RED)Directory 21-Quiz-App not found$(NC)\n"; \
	fi

.PHONY: project-22
project-22:
	@printf "$(GREEN)=== 22-Flutter-Magic-8-Ball-App Project ===$(NC)\n"
	@printf "$(GREEN)start building project 22-Flutter-Magic-8-Ball-App...$(NC)\n"
	@if [ -d "22-Flutter-Magic-8-Ball-App" ]; then \
		cd 22-Flutter-Magic-8-Ball-App && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 22-Flutter-Magic-8-Ball-App$(NC)\n"; \
	else \
		printf "$(RED)Directory 22-Flutter-Magic-8-Ball-App not found$(NC)\n"; \
	fi

.PHONY: project-23
project-23:
	@printf "$(GREEN)=== 23-TaskFlow Project ===$(NC)\n"
	@printf "$(GREEN)start building project 23-TaskFlow...$(NC)\n"
	@if [ -d "23-TaskFlow" ]; then \
		cd 23-TaskFlow && \
		printf "$(YELLOW)Running flutter doctor...$(NC)\n" && flutter doctor -v && \
		printf "$(YELLOW)Getting dependencies...$(NC)\n" && flutter pub get && \
		printf "$(YELLOW)Analyzing...$(NC)\n" && flutter analyze && \
		printf "$(YELLOW)Running tests...$(NC)\n" && flutter test && \
		printf "$(YELLOW)Building Android APK...$(NC)\n" && flutter build apk --release && \
		printf "$(YELLOW)Building iOS...$(NC)\n" && flutter build ios --debug --no-codesign; \
		printf "$(GREEN)finished building project 23-TaskFlow$(NC)\n"; \
	else \
		printf "$(RED)Directory 23-TaskFlow not found$(NC)\n"; \
	fi

# Help target
.PHONY: help
help:
	@printf "$(GREEN)Flutter Playground Build Tool$(NC)\n"
	@echo ""
	@printf "$(YELLOW)Available targets:$(NC)\n"
	@echo "  all              - Run all commands for all projects"
	@echo "  doctor           - Run flutter doctor for all projects"
	@echo "  pub-get          - Get dependencies for all projects"
	@echo "  analyze          - Analyze all projects"
	@echo "  test             - Run tests for all projects"
	@echo "  build-android    - Build Android APK for all projects"
	@echo "  build-ios        - Build iOS for all projects"
	@echo "  clean            - Clean all projects"
	@echo ""
	@printf "$(YELLOW)Individual project targets:$(NC)\n"
	@echo "  hello-flutter    - Run all commands for HelloFlutter project"
	@echo "  project-01       - Run all commands for 01-Flutter-Widgets"
	@echo "  project-02       - Run all commands for 02-Flutter-UI-Components"
	@echo "  project-03       - Run all commands for 03-Flutter-Design-Animations"
	@echo "  project-04       - Run all commands for 04-Flutter-Forms-Gestures"
	@echo "  project-05       - Run all commands for 05-Flutter-Navigation-Routing"
	@echo "  project-06       - Run all commands for 06-Flutter-Accessing-Device"
	@echo "  project-07       - Run all commands for 07-Flutter-Advanced-Concepts"
	@echo "  project-21       - Run all commands for 21-Quiz-App"
	@echo "  project-22       - Run all commands for 22-Flutter-Magic-8-Ball-App"
	@echo "  project-23       - Run all commands for 23-TaskFlow"
	@echo ""
	@printf "$(YELLOW)Usage examples:$(NC)\n"
	@echo "  make all                    # Run everything for all projects"
	@echo "  make doctor                 # Check Flutter installation"
	@echo "  make pub-get                # Get dependencies"
	@echo "  make test                   # Run tests for all projects"
	@echo "  make project-01             # Run all commands for project 01"
	@echo "  make build-android          # Build Android APKs only"
	@echo "  make build-ios              # Build iOS for all projects"
